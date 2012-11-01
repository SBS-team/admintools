class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
         # :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :authentication_keys => [ :email ]
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_protected :role, :as => :user
  attr_accessor :changer

  acts_as_paranoid

  self.per_page = 10
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}

  has_one  :desktop

  has_many :devices

  has_many :voteds

  has_many :absents

  has_many :users_change, :as => :editor, :class_name => 'UserChange'

  has_many :user_changes, :foreign_key => "edited_id"

  has_one :room, :through => :desktop

  # self join
  has_many :subordinates, :class_name => "User", :foreign_key => "manager_id"
  belongs_to :manager, :class_name => "User"

  belongs_to :department

  has_many :reports

  validates :first_name,    :presence => true
  validates :last_name,     :presence => true
  validates :email,         :presence => true, :uniqueness => true
  validates :skype,         :presence => true

  validates :birthday,      :if => :by_user,
                            :presence => true,
                            :format => { :with => /\d{4}\-\d{2}\-\d{2}/ }
  validates :daily,         :if => :by_user,
                            :presence => true,
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
  scope :two_week_birthday, lambda {where("birthday < ? and birthday >= ?", Time.now.to_date+14.days,Time.now.to_date).order("birthday ASC")}

  scope :out_of_work, where("`users`.`employer` = ''")

  def is_user?
    self.role.eql?'user'
  end

  def is_admin?
    self.role.eql?'admin'
  end

  def is_manager?
    self.role.eql?'manager'
  end

  def is_teamleader?
    self.role.eql?'teamleader'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  before_update :write_log
  before_update :toggle_out_of_work

  def self.subordinates(collect, user)
    collect.where(:users => {:role => 'user', :department_id => user.department_id})
  end

  private

  def by_user
    self.changer.is_a?User if self.changer
  end

  def write_log
    UserChange.create(:editor => self.changer,
                      :edited_id => self.id,
                      :change => self.changes) if(self.changer && self.changed?)
  end

  def toggle_out_of_work
    if self.changes.has_key?(:employer)
      if self.changes[:employer][0].present? && self.changes[:employer][1].empty?
        self.out_of_work = Time.zone.now
      end
      if self.changes[:employer][0].empty? && self.changes[:employer][1].present?
        self.out_of_work = nil
      end
    end
  end
end