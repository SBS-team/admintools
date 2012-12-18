class MaterialRequest < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :priority, :status

  validates :name, :presence => true

  scope :unconfirmed, where(:status => nil)
  scope :unprocessed, where(:status => false)
  scope :by_department, lambda {|department| where(:user_id => department.user_ids)}
end
