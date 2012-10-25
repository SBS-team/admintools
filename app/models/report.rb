class Report < ActiveRecord::Base
  attr_accessible :body, :report_send, :user_id, :teamleader_report_id
  validates :body, :presence => true

  has_many :users_reports, :class_name => "Report", :foreign_key => 'teamleader_report_id'
  belongs_to :teamleader_report, :class_name => "Report", :dependent => :destroy
  belongs_to :user

  scope :users_unsended_reports, joins(:user).where(:report_send => false)
end
