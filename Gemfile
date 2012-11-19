source 'https://rubygems.org'

gem "rails", "3.2.8"
gem "haml", "~> 3.1.7"
gem "mysql2", "~> 0.3.11"
gem "devise", "~> 2.1.2"
gem "haml-rails", "~> 0.3.4"
gem "meta_search", "~> 1.1.3"
gem "will_paginate", "~> 3.0.3"
gem "resque-scheduler", :require => "resque_scheduler"
gem "curb", "~> 0.8.1"
gem "thin", "~> 1.4.1"
gem "cancan"

git 'git://github.com/goncalossilva/rails3_acts_as_paranoid.git' do
  gem 'rails3_acts_as_paranoid'
end
group :assets do
  gem "twitter-bootstrap-rails", "~> 2.1.3"
  gem "sass-rails",   "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier"
end

group :development do
  gem "capistrano"
  gem "rvm-capistrano"
  gem 'faker'
end

group :production do
  gem "unicorn"
end
gem "jquery-rails", "~> 2.1.1"
gem "redis", "~> 3.0.1"
gem "resque", "~> 1.22.0"

gem "rspec-rails", :group => [:test, :development]

group :test do
  gem "factory_girl_rails", "~> 4.0.0"
  gem "capybara", "~> 1.1.2"
  gem "cucumber"
  gem "capybara-mechanize"
  gem "database_cleaner", "~> 0.8.0"
  gem "guard-rspec", "~> 1.2.1"
  gem "shoulda-matchers", "~> 1.2.0"
  gem "xpath", "~> 0.1.4"
end

gem 'capistrano'
gem 'capistrano-resque'
