class Room < ActiveRecord::Base
  attr_accessible :name, :user_id

  has_many :desktops
  has_many :users, :through => :desktops
  belongs_to :user

  validates :name, :presence => true, :uniqueness => true
  validates :user_id, :presence => true, :uniqueness => true

end
