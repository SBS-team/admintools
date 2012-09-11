ENV["REDISTOGO_URL"] ||= "redis://localhost:6379/"
uri = URI.parse(ENV["REDISTOGO_URL"])

$redis = Redis.current
$redis.client.disconnect
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

# $redis.select 1
redis_count = $redis.get(:count).to_i
$redis.set :count, redis_count ? $redis.smembers(:local_ping).length : 0