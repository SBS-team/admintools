class Admin < ActiveRecord::Base
  self.per_page = 10

  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_many :event_admins, :dependent => :delete_all
  has_many :events, :through => :event_admins

  SUPER_ADMIN = "admin"

  def is_super_admin?
    name == SUPER_ADMIN
  end
end
