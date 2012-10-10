class Poll < ActiveRecord::Base
  attr_accessible :end_at, :max_votes, :option, :question, :visible
  serialize :option,Array
  has_many :voteds
end
