class RoomPlan < ActiveRecord::Base
  belongs_to :room
  has_many :workplaces
end