class Task < ActiveRecord::Base
  attr_accessible :creator_id, :description, :execution_date, :priority, :task, :title, :user_id

  belongs_to :user
  belongs_to :creator, :class_name => "User", :foreign_key => "creator_id"

  PRIORITY = %w(low medium high)
end
