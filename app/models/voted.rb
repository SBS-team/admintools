class Voted < ActiveRecord::Base
  attr_accessible :option_id, :option_vote, :poll_id, :user_id
  belongs_to :user
  belongs_to :poll
end
