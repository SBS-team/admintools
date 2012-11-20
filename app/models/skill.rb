class Skill < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  acts_as_paranoid

  has_many :skill_user_relations, :dependent => :destroy
  has_many :users, :through => :skill_user_relations
end