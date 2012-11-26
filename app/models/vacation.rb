class Vacation < ActiveRecord::Base
  attr_accessible :date_from, :date_to, :user_id, :approved

  belongs_to :user

  validates :user_id, :presence => true

  scope :by_year, lambda {|v| where("YEAR(date_from) = ? OR YEAR(date_to) = ?", v, v)}



  def date_for_year(year)
    if self.date_from.year != year
      self.date_from = self.date_to.beginning_of_year
    end
    if self.date_to.year != year
      self.date_to = self.date_from.end_of_year
    end
  end

end