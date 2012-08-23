class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  # Setup accessible (or protected) attributes for your model
  # attr_accessible :title, :body
end
