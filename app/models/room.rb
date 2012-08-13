class Room < ActiveRecord::Base
  attr_accessible :office, :responsible

  has_many :desktops

end
