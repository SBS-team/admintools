class Poll < ActiveRecord::Base
  attr_accessible :end_at, :max_votes, :option, :question, :visible, :user_id
  serialize :option,Array
  has_many :voteds
  belongs_to :user

  validates :question, :presence => true
  validates :max_votes, :numericality => {:greater_than => 0}
  validate :option_validation

  before_validation ->{ self.end_at = 1.day.from_now if self.end_at < DateTime.now }

protected
  def option_validation
    if self.option.delete_if { |x| x.blank? }.count < 2
      errors.add(:option, :wrong_option_count)
    end
  end
end
