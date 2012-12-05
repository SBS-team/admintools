class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
         # :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :trackable, :validatable, :recoverable,:authentication_keys => [ :email ]
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_protected :role, :as => :user
  attr_accessor :changer

  acts_as_paranoid

  before_update :write_log
  before_update :toggle_out_of_work

  self.per_page = 10

  has_one  :desktop

  has_many :devices

  has_many :voteds

  has_many :absents

  has_many :users_change, :as => :editor, :class_name => 'UserChange'

  has_many :user_changes, :foreign_key => "edited_id"

  has_many :skill_user_relations, :dependent => :destroy

  has_many :skills, :through => :skill_user_relations

  has_one :room, :through => :desktop

  # self join
  has_many :subordinates, :class_name => "User", :foreign_key => "manager_id"
  belongs_to :manager, :class_name => "User"

  belongs_to :department

  has_many :reports

  has_many :polls

  has_many :relationships, foreign_key: 'manager_id', dependent: :destroy
  has_many :managed_users, through: :relationships, source: :managed
  has_many :reverse_relationships, foreign_key: 'managed_id',
           class_name:  'Relationship',
           dependent:   :destroy
  has_many :user_managers, through: :reverse_relationships, source: :manager
  has_many :vacations, :dependent => :destroy

  validates :first_name,    :presence => true
  validates :last_name,     :presence => true
  validates :skype,         :presence => true

  validates :birthday,      :if => :by_user,
                            :presence => true,
                            :format => { :with => /\d{4}\-\d{2}\-\d{2}/ }
  validates :daily_1, :daily_2,
            :daily_3, :daily_4,
            :daily_5,       :if => :by_user,
                            :presence => true,
                            :format => { :with => /^\d{2}\:\d{2}\-\d{2}\:\d{2}$/ }

  validates :department_id, :numericality => { :greater_than => 0 },
                            :if => :department_id?

  validates :role,          :uniqueness => { :scope => :department_id, :message => :one_leader },
                            :if => :set_teamleader


  ROLES = %w[user teamleader manager admin]

  scope :by_name, lambda { order(:last_name, :first_name) }
  scope :managers, lambda { where(:role => ['manager']) }
  scope :admins, lambda { where(:role => ['admin']) }
  scope :out_department, lambda { where(:department_id => nil, :role => [:user, :teamleader]) }
  scope :for_manager, lambda { where(:role => ['teamleader', 'user']).order(:last_name, :first_name) }
  scope :teamleader_users, lambda { |u| where(:role => 'user', :department_id => u.department_id).order(:last_name, :first_name) }
  scope :user_teamleader, lambda {|u| where(:role =>'teamleader',:department_id => u.department_id).order(:last_name,:first_name) }
  scope :two_week_birthday, lambda {where("birthday < ? and birthday >= ?", Time.now.to_date+14.days,Time.now.to_date).order("birthday ASC")}

  scope :out_of_work, where("`users`.`employer` = ''")

  def vacation_data(curr_user)
    {
      name: self.full_name,
      desc: "",
      values:
        self.vacations.by_year(Date.today.year).map {|vacation|
          {
            from: "/Date(\"#{vacation.date_from.strftime('%m/%d/%Y')}\")/",
            to: "/Date(\"#{vacation.date_to.strftime("%m/%d/%Y")}\")/",
            label: "---",
            customClass: "gantt#{vacation.approved ? "Green" : "Red"} #{"acceptable" if curr_user.is_admin? && !vacation.approved } #{"editable" if vacation.date_to > Date.today && self.id == curr_user.id} #{"removable" if vacation.date_from > Date.today && self.id == curr_user.id}",
            dataObj: {id: vacation.id, from: vacation.date_from, to: vacation.date_to}
          }
        }
    }
  end

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

  def self.subordinates(collect, user)
    collect.where(:users => {:role => 'user', :department_id => user.department_id})
  end

  def manage! manager_id
    reverse_relationships.create!(manager_id: manager_id)
  end

  def unmanage! manager_id
    reverse_relationships.find_by_manager_id(manager_id).destroy
  end

  private

  def set_teamleader
    self.is_teamleader?
  end

  def by_user
    self.changer.is_a?User
  end

  def write_log
    UserChange.create(:editor => self.changer,
                      :edited_id => self.id,
                      :change => self.changes) if(self.changer && self.changed?)
  end

  def toggle_out_of_work
    if self.changes.has_key?(:employer)
      if self.changes[:employer][0].present? && self.changes[:employer][1].blank?
        self.out_of_work = Time.zone.now
      end
      if self.changes[:employer][0].blank? && self.changes[:employer][1].present?
        self.out_of_work = nil
      end
    end
  end
end