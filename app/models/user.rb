class User < ActiveRecord::Base

  has_one  :desktop
  has_many :devices
  has_one :room
  has_many :event_users

  validates :first_name, :presence => true
  validates :last_name,  :presence => true
  validates :email,      :presence => true, :uniqueness => true
  validates :skype,      :presence => true

  def full_name
    "#{first_name} #{last_name}"
  end

end