class User < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}

  has_one  :desktop
  has_many :devices
  has_one :room, :through => :desktop

  attr_reader :user_tokens

  validates :first_name, :presence => true
  validates :last_name,  :presence => true
  validates :email,      :presence => true, :uniqueness => true
  validates :skype,      :presence => true

  def full_name
    "#{first_name} #{last_name}"
  end

end