# ENV["REDISTOGO_URL"] ||= "redis://localhost:6379/"
# uri = URI.parse(ENV["REDISTOGO_URL"])
# $redis = Redis.current
# $redis.client.disconnect
# $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)
# $redis.select 1
RedisTools.connect