class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
         # :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :authentication_keys => [ :email ]
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_protected :role
  attr_accessor :changer

  acts_as_paranoid

  self.per_page = 10
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}

  has_one  :desktop

  has_many :devices

  has_many :voteds

  has_many :absents

  has_many :users_change, :as=>:editor,:class_name => 'UserChange'

  has_many :user_changes, :foreign_key => "edited_id"

  has_one :room, :through => :desktop

  belongs_to :department

  has_many :reports

  validates :first_name,    :presence => true
  validates :last_name,     :presence => true
  validates :email,         :presence => true, :uniqueness => true
  validates :skype,         :presence => true
  validates :birthday,      :presence => true,
  :format => { :with => /\d{4}\-\d{2}\-\d{2}/ }
  validates :daily,         :presence => true,
                            :format => { :with => /^\d{2}\:\d{2}\-\d{2}\:\d{2}$/ }
  validates :department_id, :numericality => { :greater_than => 0 },
                            :if => :department_id?

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}


  ROLES = %w[user teamleader manager admin]

  scope :by_name, lambda { order(:last_name, :first_name) }
  scope :managers, lambda { where(:role => ['manager']) }
  scope :out_department, lambda { where(:department_id => nil, :role => [:user, :teamleader]) }
  scope :for_manager, lambda { where(:role => ['teamleader', 'user']).order(:last_name, :first_name) }
  scope :teamleader_users, lambda { |u| where(:role => 'user', :department_id => u.department_id).order(:last_name, :first_name) }
  scope :user_teamleader, lambda {|u| where(:role =>'teamleader',:department_id => u.department_id).order(:last_name,:first_name) }

  def full_name
    "#{last_name} #{first_name}"
  end

  after_update do
    UserChange.create(:editor=>self.changer,:edited_id=>self.id,:change=>self.changes)
    i=5
  end

end