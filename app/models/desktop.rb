class Desktop < ActiveRecord::Base
  attr_accessible :info, :ip, :mac

  belongs_to :room
  belongs_to :user

  validates :ip,  :presence => true, :uniqueness => true
  validates :mac, :presence => true, :uniqueness => true
  validates :user_id, :uniqueness => true
end
