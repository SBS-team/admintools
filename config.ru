# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Admintools::Application


require 'resque/server'
run Rack::URLMap.new "/" => Admintools::Application,  "/resque" => Resque::Server.new


