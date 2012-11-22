class Vacation < ActiveRecord::Base
  attr_accessible :day_from, :day_to, :month, :year, :user_id, :approved, :date_from, :date_to
  attr_accessor :date_from, :date_to
  belongs_to :user

  validates :user_id, :approved, :presence => true
  #validate :validate_params


  scope :by_month_and_year, lambda{ |month, year| where("month = ? AND year = ?", month, year) }

  before_create :prepare_values

private
  #def validate_params
  #  if date_from || date_to
  #    validates :user_id, :approved, :presence => true
  #  else
  #    validates :day_from, :day_to, :month, :year, :presence => true
  #  end
  #end

  def prepare_values
    return if self.date_from.blank? or self.date_to.blank?

    if (self.date_from.month != self.date_to.month)
      Vacation.create!(:user_id => self.user_id,
                       :day_from => self.date_from.day,
                       :day_to => self.date_from.end_of_month.day,
                       :month => self.date_from.month,
                       :year => self.date_from.year,
                       :approved => self.approved)
      self.date_from = self.date_to.beginning_of_month
    end

    self.day_from = self.date_from.day
    self.month = self.date_from.month
    self.year = self.date_from.year
    self.day_to = self.date_to.day
  end
end
