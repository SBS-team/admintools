class Room < ActiveRecord::Base
  attr_accessible :office, :responsible

  has_many :desktops
  has_many :users, :through => :desktops

  validates :office, :presence => true
  validates_uniqueness_of :office
  validates :responsible, :presence => true

end
