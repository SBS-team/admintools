class Device < ActiveRecord::Base
  attr_accessible :ip, :mac, :name, :user_id

  belongs_to :user

end
