class Admin < ActiveRecord::Base

  acts_as_paranoid

  self.per_page = 10

  devise :database_authenticatable, :rememberable, :trackable, :validatable, :authentication_keys => [ :name ]

  has_many :event_admins, :dependent => :delete_all
  has_many :events, :through => :event_admins

  has_many :users_change, :as=>:editor,:class_name => 'UserChange'

  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true

  SUPER_ADMIN = "admin"

  def is_super_admin?
    name == SUPER_ADMIN
  end
end
