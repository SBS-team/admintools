class SkillUserRelation < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :skill
  belongs_to :user
end