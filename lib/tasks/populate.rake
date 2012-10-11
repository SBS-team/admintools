# Resque tasks
require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :populate do
  desc "Populate `users` table by 200 users"
  task :users => :environment do
    User.delete_all
    (1..200).each do |n|
      User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: "email_#{n}@email.com",
        phone: Faker::PhoneNumber.phone_number,
        skype: "skype_#{n}",
        info: Faker::Lorem.sentences( 9 ),
        password: "123456",
        password_confirmation: "123456",
        birthday: "1999-10-10",
        daily: "07:00-19:00",
        employer: Faker::Name.name,
        odesk: Faker::Internet.url,
      )
    end
  end
end