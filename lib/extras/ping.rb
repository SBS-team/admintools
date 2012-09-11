require 'timeout'
require 'socket'

class Ping
  def self.pingecho(desktop, timeout=5, service="echo")
    begin
      timeout(timeout) do
        s = TCPSocket.new(desktop.ip, "echo")
        s.close
      end
      rescue Errno::ECONNREFUSED
        status = "up"
      rescue Timeout::Error, StandardError
        status = "down"
      else 
        status = "up"
    end
    # DEBUG
    puts status
  end

  def self.multiecho(hardwares)
    unreg = (1..255).map{ |seg| "192.168.137.#{seg}" }
    thread_ping(hardwares).each do |t|
      t.join
      $redis.client.reconnect
      self.ping_true(t[:ip], t[:hardware]) if t[:status].eql? "up"
      self.ping_fail(t[:ip], t[:hardware]) if t[:status].eql? "down"
      unreg.delete t[:hardware].ip
      # DEBUG
      debug_data do
        puts "#{t[:hardware].ip} \t Up" if t[:status].eql? "up"
        # self.ping_fail(t[:ip], t[:hardware]) if t[:ip].match(/\.(\d+)$/)[1].to_i > 10
      end
    end
    thread_ping(unreg).each do |t|
      t.join
      $redis.client.reconnect
      self.ping_true(t[:ip]) if t[:status].eql? "up"
      self.ping_fail(t[:ip]) if t[:status].eql? "down"
      # DEBUG
      debug_data do
        puts "#{t[:ip]} \t Up \t unregist" if t[:status].eql? "up"
        # self.ping_fail(t[:ip]) if t[:ip].match(/\.(\d+)$/)[1].to_i > 50
      end
    end
  end

  # DEBUG
  # clear redis data
  def self.clear_all_redis
    $redis.set :count, 0
    (1..255).map do |x|
      $redis.srem :local_ping, "192.168.137.#{x}"
      $redis.hdel "192.168.137.#{x}", :up
      $redis.hdel "192.168.137.#{x}", :down
      $redis.hdel "192.168.137.#{x}", :mac
    end
  end

  private 

  def self.debug_data
    yield if Rails.env.development?
  end

  def self.define_mac(ip)
    if mac = `arp -a #{ip}`.match(/\b((?:[A-Fa-f0-9]{2}[:-]){5}[A-Fa-f0-9]{2})\b/)
      return mac[1]
    end
  end

  def self.thread_ping(collect, timeout=5, service="echo")
    threads = []
    for fetch_to_ping in collect do
      threads << Thread.new(fetch_to_ping) do |hardware|
        begin
          if hardware.class.eql?String
            ip = Thread.current[:ip] = hardware
            Thread.current[:hardware] = false
          else
            ip = Thread.current[:ip] = hardware.ip
            Thread.current[:hardware] = hardware
          end
          timeout(timeout) do
            s = TCPSocket.new(ip, service)
            s.close
          end
          rescue Errno::ECONNREFUSED
            Thread.current[:status] = "up"
          rescue Timeout::Error, StandardError
            Thread.current[:status] = "down"
        end
        Thread.current[:status] ||= "up"
      end
    end
    return threads
  end

  def self.ping_true(ip, hardware=nil)
    unless $redis.sismember :local_ping, ip
      $redis.sadd :local_ping, ip
      $redis.hset ip, :up, Time.now
      $redis.incr(:count)
      unless hardware || $redis.hexists(ip, :mac)
        mac = self.define_mac(ip)
        $redis.hset ip, :mac, mac if mac
        debug_data{ puts "get mac for #{ip}" }
      end
    end
  end

  def self.ping_fail(ip, hardware=nil)
    if $redis.get(:count).to_i > 0
      if ($redis.exists :local_ping) && ($redis.hexists ip, :up) && ($redis.sismember :local_ping, ip)
        $redis.hset ip, :down, Time.now
        if (hardware)
          hardware.ping_logs.create(
            :up => $redis.hget(ip, :up).to_datetime.to_s(:db),
            :down => $redis.hget(ip, :down).to_datetime.to_s(:db)
          )
          debug_data{ puts "New rec for registered #{ip}" }
        else 
          PingLog.create(
            :up => $redis.hget(ip, :up).to_datetime.to_s(:db),
            :down => $redis.hget(ip, :down).to_datetime.to_s(:db),
            :unregister_ip => ip,
            :mac => $redis.hget(ip, :mac)
          )
          debug_data{ puts "New rec for UNregistered #{ip}" }
        end
        $redis.hdel ip, :up
        $redis.hdel ip, :down
        $redis.hdel ip, :mac
        $redis.srem :local_ping, ip
        $redis.decr(:count)
      end
    end
  end
end