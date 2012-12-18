class TimeRequest < ActiveRecord::Base
  attr_accessible :message, :request_date, :requested_time
  default_scope ->{where("request_date > ?", Date.today.prev_month.end_of_month)}

  belongs_to :user

  #validates :user_id, :uniqueness => {:scope => :request_date}
  validate :date_validate

  def request_date
    (super || Date.today).beginning_of_month
  end

private
  def date_validate
    errors.add(:request_date, :wrong_date_range) if self.request_date <= Date.today.prev_month.end_of_month
  end
end
