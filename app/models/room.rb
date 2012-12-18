class Room < ActiveRecord::Base
  self.per_page = 10
  belongs_to :user
  has_one  :room_plan, :dependent => :destroy
  has_many :desktops, :dependent => :destroy
  has_many :users, :through => :desktops, :dependent => :destroy
  has_many :workplaces, :through => :room_plan

  validates :name, :presence => true, :uniqueness => true
  validates :user_id, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :room_plan, :allow_destroy => true
end