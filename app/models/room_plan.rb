class RoomPlan < ActiveRecord::Base
  belongs_to :room
  has_many :workplaces
  has_many :desktops, :through => :room
  has_many :desktops, :through => :workplaces
end