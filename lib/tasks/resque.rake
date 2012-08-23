require 'resque/tasks'
require 'resque_scheduler/tasks'
task "resque:setup" => :environment
task "jobs:work" => "resque:work"

namespace :resque do
  task :setup do
    ENV['QUEUE'] = '*'
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'

    Resque.redis = 'localhost:6379'

    Resque.schedule = YAML.load_file("#{Rails.root}/config/rescue_schedule.yml")
  end
end