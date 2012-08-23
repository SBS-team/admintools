class User < ActiveRecord::Base

  has_one  :desktop
  has_many :devices
  has_one :room, :through => :desktop

  attr_accessible :email, :first_name, :info, :last_name, :skype, :user_tokens

  attr_reader :user_tokens
  has_many :event_users
  has_many :events, :through => :event_users

  validates :first_name, :presence => true
  validates :last_name,  :presence => true
  validates :email,      :presence => true, :uniqueness => true
  validates :skype,      :presence => true

  def full_name
    "#{first_name} #{last_name}"
  end

  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end
end