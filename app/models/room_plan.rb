class RoomPlan < ActiveRecord::Base
  belongs_to :room
  has_many :workplaces, :dependent => :destroy
  has_many :desktops, :through => :workplaces, :dependent => :destroy
end