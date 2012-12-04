class Vacation < ActiveRecord::Base
  attr_accessible :date_from, :date_to, :user_id, :approved

  belongs_to :user

  validates :user_id, :presence => true

  scope :by_year, lambda {|v| where("YEAR(date_from) = ? OR YEAR(date_to) = ?", v, v)}
end