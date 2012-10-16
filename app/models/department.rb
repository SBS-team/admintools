class Department < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :name, :presence => true, :uniqueness => true

  has_many :users, :foreign_key => "department_id"
end