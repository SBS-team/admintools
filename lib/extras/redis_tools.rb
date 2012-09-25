class RedisTools
  def self.connect
    ENV["REDISTOGO_URL"] ||= "redis://localhost:6379/"
    uri = URI.parse(ENV["REDISTOGO_URL"])
    $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)
    $redis.select 1
  end

  def self.reload
    $redis.client.disconnect
    self.connect
  end
  # clear Redis by log list
  def self.clear_by_log(logs=nil)
    RedisTools.reload
    logs.each do |l|
      if $redis.sismember(:logs, l.id)
        ip = $redis.hget l.id, :ip
        $redis.del ip
        $redis.del l.id
        $redis.srem(:local_ping, ip)
        $redis.srem(:logs, l.id)
      end
    end
  end

  def self.flush
    $redis.flushdb
  end
end