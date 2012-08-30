class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable,
         :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :title, :body
  has_many :event_admins, :dependent => :delete_all
  has_many :events, :through => :event_admins

  SUPER_ADMIN = "admin"

  def is_super_admin?
    name == SUPER_ADMIN
  end

end
