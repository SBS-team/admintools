class Admin < ActiveRecord::Base
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  has_many :event_admins, :dependent => :delete_all
  has_many :events, :through => :event_admins

  def user_tokens=(ids)
    self.user_ids = ids.split(",")
  end

  SUPER_ADMIN = "admin"

  def is_super_admin?
    name == SUPER_ADMIN
  end

end
