class Desktop < ActiveRecord::Base
  attr_accessible :info, :ip, :mac, :user_id

  belongs_to :room
  belongs_to :user

end
