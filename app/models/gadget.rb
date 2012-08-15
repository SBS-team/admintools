class Gadget < ActiveRecord::Base
  attr_accessible :ip, :mac, :name
  belongs_to :user

  validates :ip,  :presence => true, :uniqueness => true
  validates :mac, :presence => true, :uniqueness => true
end
