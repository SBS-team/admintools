# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Admin.create(:name => "admin", :email => "admin@admin.ua", :password => "123456", :password_confirmation => "123456")
Role.create(:name=>'user')
Role.create(:name=>'manager')
Role.create(:name=>'room_boss')