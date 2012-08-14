class Room < ActiveRecord::Base
  attr_accessible :office, :responsible

  has_many :desktops

  validates :office, :presence => true, :uniqueness => true
  validates :responsible, :presence => true

end
