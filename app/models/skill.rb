class Skill < ActiveRecord::Base
  has_many :skill_user_relations
end