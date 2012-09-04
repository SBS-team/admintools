class User < ActiveRecord::Base

  self.per_page = 10
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}

  has_one  :desktop
  has_many :devices
  has_one :room, :through => :desktop

  validates :first_name, :presence => true
  validates :last_name,  :presence => true
  validates :email,      :presence => true, :uniqueness => true
  validates :skype,      :presence => true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}

  def full_name
    "#{first_name} #{last_name}"
  end
end