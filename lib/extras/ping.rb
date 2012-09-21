require 'timeout'
require 'socket'

class Ping

  def self.multiecho(hardwares)
    networks = Subnetwork.all
    unreg = []
    if networks
      networks.each do |n|
        mask = n.network.match(/^(\d{1,3}\.\d{1,3}\.\d{1,3})/)
        unreg << (1..255).map{ |seg| "#{mask[1]}.#{seg}"}
      end
    end
    unreg.flatten!
    hardwares.each do |i|
      unreg.delete_if{ |x| x.eql? i.ip }
    end
    thread_ping(hardwares + unreg).each do |t|
      t.join
      $redis.client.reconnect
      ping_true(t[:ip], t[:hardware]) if t[:status].eql? "up"
      ping_fail(t[:ip], t[:hardware]) if t[:status].eql? "down"
      # puts t[:ip] if t[:status].eql? "up"
    end
  end

  private

  def self.define_mac(ip)
    mac = `arp -a #{ip}`.match(/\b((?:[A-Fa-f0-9]{2}[:-]){5}[A-Fa-f0-9]{2})\b/)
    return mac ? mac[1] : nil
  end

  def self.debug_data
    yield if Rails.env.development?
  end

  def self.thread_ping(collect, timeout=5, service="echo")
    threads = []
    for fetch_to_ping in collect do
      threads << Thread.new(fetch_to_ping) do |hardware|
        begin
          if hardware.is_a?String
            ip = Thread.current[:ip] = hardware
            Thread.current[:hardware] = nil
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
      unless hardware
        mac = define_mac(ip)
        log = PingLog.new()
      else
        mac = hardware.mac
        log = hardware.ping_logs.new()
      end
      log.attributes = {:up => Time.zone.now, :ip => ip, :mac => mac}
      if mac && log.save
        $redis.hset log.id, :ip, ip
        $redis.hset ip, :log_id, log.id
        $redis.sadd :local_ping, ip
        $redis.sadd :logs, log.id
      end
    end
  end

  def self.ping_fail(ip, hardware=nil)
    if $redis.sismember(:local_ping, ip) && $redis.hexists(ip, :log_id)
      if log_record = $redis.hget(ip, :log_id)
        if log = PingLog.find_by_id(log_record.to_i)
          if log.update_attributes(:down => Time.zone.now)
            $redis.del ip
            $redis.del log_record
            $redis.srem :local_ping, ip
            $redis.srem :logs, log_record
          end
        end
      end
    end
  end

end

__END__

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