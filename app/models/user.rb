class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :info, :last_name, :skype

  has_one  :desktop
  has_many :devices
  has_many :rooms

end
