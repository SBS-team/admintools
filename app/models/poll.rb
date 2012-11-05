class Poll < ActiveRecord::Base
  attr_accessible :end_at, :max_votes, :option, :question, :visible, :user_id
  serialize :option,Array
  has_many :voteds
  belongs_to :user
end
