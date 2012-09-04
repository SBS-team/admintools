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
  def self.multiecho(desktops, timeout=5, service="echo")
    threads = []
    for fetch_to_ping in desktops do
      threads << Thread.new(fetch_to_ping) do |desktop|
        begin
          Thread.current[:desktop] = desktop
          timeout(timeout) do
            s = TCPSocket.new(desktop.ip, service)
            s.close
          end
          rescue Errno::ECONNREFUSED
            Thread.current[:status] = "up"
          rescue Timeout::Error, StandardError
            Thread.current[:status] = "down"
          else 
            Thread.current[:status] = "up"
        end
      end
    end
    threads.each do |t|
      t.join
      self.ping_true(t[:desktop]) if t[:status].eql? "up"
      self.ping_fail(t[:desktop]) if t[:status].eql? "down"
      # DEBUG
      puts "#{t[:desktop].ip} Up" if t[:status].eql? "up"
      # self.ping_fail(t[:desktop]) if t[:desktop].ip.match(/\.(\d+)$/)[1].to_i > 1
    end
  end
  # DEBUG
  def self.clear_redis
    (1..255).each.map do |x|
      $redis.srem :local_ping, "192.168.137.#{x}"
      $redis.hdel "192.168.137.#{x}", :up
      $redis.hdel "192.168.137.#{x}", :down
      $redis.srem :ping_local, "192.168.137.#{x}"
      $redis.hdel "192.168.137.#{x}", :up_time
      $redis.hdel "192.168.137.#{x}", :down_time
      $redis.set :count, 0
    end
  end

  private 

  def self.ping_true(desktop)
    unless $redis.sismember :local_ping, desktop.ip
      $redis.sadd :local_ping, desktop.ip
      $redis.hset "#{desktop.ip}", :up, Time.now
      $redis.incr(:count)
    end
  end
  def self.ping_fail(desktop)
    if $redis.get(:count).to_i > 0
      if ($redis.exists :local_ping) && ($redis.hexists "#{desktop.ip}", :up)
        $redis.hset "#{desktop.ip}", :down, Time.now
        times = $redis.hmget "#{desktop.ip}", :up, :down        
        if LocalPing.create(:desktop_id => desktop.id, :up => $redis.hget("#{desktop.ip}",:up),  :down => $redis.hget("#{desktop.ip}", :down)).save
          $redis.hdel "#{desktop.ip}", :up
          $redis.hdel "#{desktop.ip}", :down
          $redis.decr(:count)
          $redis.srem :local_ping, desktop.ip
        end
      end
    end
  end
end
__END__

Logic
_____________________
ping_fail
   if redis_count>0
     @desktop=select from REDIS by IP
     if @desktop present
      @desktop update (:down_time=>Time.now)
      remove @dekstop from Redis and ADD it to DB
      redis_count-1
     end
   end
_____________________
ping_good 
  
  if not present (select from REDIS by ip)
    create new desktop in REDIS
    redis_count+1
  end