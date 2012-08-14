class Room < ActiveRecord::Base
  attr_accessible :office, :responsible

  has_many :desktops
  belongs_to :user

  validates :office, :presence => true
  validates_uniqueness_of :office
  validates :responsible, :presence => true

end
