#encoding=UTF-8
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl'
require 'capybara/rspec'
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
  config.include Devise::TestHelpers, :type => :controller

end

def auth_for(type, &block)
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in FactoryGirl.create(type)
  end
  describe "with a loggined admin" do
    yield
  end
end

def login_admin
  @admin = FactoryGirl.create(:admin)
  visit new_admin_session_path

  within "#new_admin" do
    fill_in 'Name', :with => @admin.name
    fill_in 'Password', :with => "secret"
  end
  click_button('Sign in')
end

#def room_creating
#  @user = FactoryGirl.create(:user)
#  visit new_room_path
#  sleep(1000)
#
#  within "#new_room" do
#    fill_in 'room_name', :with => '5'
#    fill_in 'room_user_id', :with => @user.full_name
#  end
#    #fill_in 'Номер офиса', :with => '5'
#    #fill_in 'Пользователь', :with => @user.full_name
#
#  click_button 'Создать'
#end