class Report < ActiveRecord::Base
  attr_accessible :body, :report_send, :user_id
  validates :body, :presence => true

  belongs_to :user
end
