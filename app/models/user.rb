class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :info, :last_name, :skype

  has_one  :desktop
  has_many :devices
<<<<<<< HEAD
  has_many :rooms
=======
  
  validates :first_name, :presence => true
  validates :last_name,  :presence => true
  validates :email,      :presence => true
  validates_uniqueness_of :email

>>>>>>> 7bf0a03c3e69197fbae69373b4539544a1dd9a06

end
