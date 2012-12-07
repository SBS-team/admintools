# uri = URI.parse("redis://localhost:6379/")
# Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

require 'resque/server'

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }