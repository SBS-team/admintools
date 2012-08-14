class Room < ActiveRecord::Base
  attr_accessible :office, :user_id

  has_many :desktops
  has_many :users, :through => :desktops
  belongs_to :user

  validates :office, :presence => true
  validates_uniqueness_of :office
  validates :user_id, :presence => true, :uniqueness => true

end
