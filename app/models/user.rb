class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
         # :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :authentication_keys => [ :email ]
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_protected :role

  self.per_page = 10
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}

  has_one  :desktop
  has_many :devices

  has_many :voteds

  has_one :room, :through => :desktop

  belongs_to :department

  validates :first_name,    :presence => true
  validates :last_name,     :presence => true
  validates :email,         :presence => true, :uniqueness => true
  validates :skype,         :presence => true
  validates :birthday,      :presence => true,
                            :format => { :with => /\d{4}\-\d{2}\-\d{2}/ }
  validates :daily,         :presence => true,
                            :format => { :with => /^\d{2}\:\d{2}\-\d{2}\:\d{2}$/ }
  # validates :department_id, :presence => true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}

  ROLES = %w[user teamleader manager admin]

  scope :for_manager, lambda { where(:role => ['teamleader', 'user']).order(:last_name, :first_name) }
  scope :for_teamleader, lambda { |u| where(:role => 'user', :department_id => u.department_id).order(:last_name, :first_name) }

  def full_name
    "#{last_name} #{first_name}"
  end
end