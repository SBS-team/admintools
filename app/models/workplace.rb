class Workplace < ActiveRecord::Base
  belongs_to :room_plan
  belongs_to :desktop
end
