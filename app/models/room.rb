class Room < ActiveRecord::Base
  belongs_to :user
  
  has_one  :room_plan
  has_many :desktops
  has_many :users, :through => :desktops
  has_many :workplaces, :through => :room_plan

  validates :name, :presence => true, :uniqueness => true
  validates :user_id, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :room_plan, :allow_destroy => true
end