class Department < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :name, :presence => true,
                   :uniqueness => { :case_sensitive => false }


  acts_as_paranoid

  has_many :users, :dependent => :nullify
end