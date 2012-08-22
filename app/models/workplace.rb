class Workplace < ActiveRecord::Base
  belongs_to :room_plan
  belongs_to :desktop
  has_one :user, :through => :desktop
end
