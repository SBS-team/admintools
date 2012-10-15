class Department < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :name, :presence => true, :uniqueness => true

  has_one :user, :foreign_key => "department_id"
end