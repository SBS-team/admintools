class MaterialRequest < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :priority, :status

  scope :unconfirmed, where(:status => nil)
  scope :unprocessed, where(:status => false)
end
