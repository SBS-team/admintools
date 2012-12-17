class Task < ActiveRecord::Base
  attr_accessible :creater_id, :description, :execution_date, :priority, :task, :title, :user_id
end
