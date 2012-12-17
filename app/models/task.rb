class Task < ActiveRecord::Base
  attr_accessible :creator_id, :description, :execution_date, :priority, :task, :title, :user_id


end
