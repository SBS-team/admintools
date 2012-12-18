# Resque tasks
require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :populate do
  desc "Populate `users` table by 200 users"
  task :users => :environment do
    User.delete_all
    (1..50).each do |n|
      User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: "email_#{n}@email.com",
        phone: Faker::PhoneNumber.phone_number,
        skype: "skype_#{n}",
        info: Faker::Lorem.sentences( 9 ),
        password: "123456",
        password_confirmation: "123456",
        birthday: "#{rand(1950..2000)}-0#{rand(1..9)}-0#{rand(1..9)}",
        daily_1: "07:00-19:00",
        daily_2: "07:00-19:00",
        daily_3: "07:00-19:00",
        daily_4: "07:00-19:00",
        daily_5: "07:00-19:00",
        daily_6: "07:00-19:00",
        daily_7: "07:00-19:00",
        employer: Faker::Name.name,
        odesk: Faker::Internet.url,
        role: 'user'
      )
    end
  end

  desc "Populate `skills`"
  task :skills => :environment do
    #Skill.delete_all
    #(1..50).each do |n|
    #  Skill.create!(name: Faker::Name.name)
    #end
  end

  desc "Populate `vacations`"
  task :vacations => :environment do
    years = [Date.today.year - 1, Date.today.year]
    Vacation.delete_all
    users = User.all.map(&:id)

    2.times do |i|
      30.times do
        date_from = Date.new(years[rand(years.length)], rand(11) + 1, rand(28) + 1)
        User.find(users[rand(users.length - 1)]).vacations.create(:date_from => date_from,
                                                                  :date_to => date_from + (rand(20) + 1).days,
                                                                  :approved => i == 1)
      end
    end
  end
end