class TimeRequest < ActiveRecord::Base
  default_scope ->{where("MONTH(date) >= ? AND YEAR(date) >= ? ", Date.today.month, Date.today.year)}

  #attr_accessible :reason, :user_id,:date_from,:date_to
  belongs_to :user

  validates :user_id, :uniqueness => {:scope => :date}
end
