class Room < ActiveRecord::Base
  attr_accessible :office, :user_id

  has_many :desktops
  has_many :users, :through => :desktops
  belongs_to :user

  validates :office, :presence => true, :uniqueness => true
  validates :responsible, :presence => true
  validates :user_id, :presence => true, :uniqueness => true
end
