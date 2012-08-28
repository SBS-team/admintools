class EventAdmin < ActiveRecord::Base
  attr_accessible :admin_id, :event_id
  belongs_to :admin
  belongs_to :event
end
