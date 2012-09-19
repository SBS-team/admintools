class RedisTools
  # clear all selected Redis DB
  def self.flush
    return $redis.flushdb
  end
  # clear Redis by log list
  def self.clear_by_log(logs=nil)
    logs.each do |l|
      if $redis.sismember(:logs, l.id)
        ip = $redis.hget l.id, :ip
        $redis.del ip
        $redis.del l.id
        $redis.srem :local_ping, ip
        $redis.srem :logs, l.id
      end
    end
  end

  private

  def self.redis_del(it=[])
    it.each do |i|
      $redis.del i
    end
  end
end