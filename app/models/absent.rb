class Absent < ActiveRecord::Base
  attr_accessible :reason, :user_id,:date_from,:date_to

  validates :reason, :presence => true
  validate :date_to_less_than_date_from

  belongs_to :user

  scope :actual_absents, lambda { |now|  joins(:user).where("absents.date_to > '#{now}'" ) }
  scope :subordinates, lambda { |u| where(:users => {:role => 'user', :department_id => u.department_id}) }

  private
  def date_to_less_than_date_from
    if self.date_to
      errors.add(:date_from, "should be less than Date to") if (date_from > date_to)
    end
  end
end
