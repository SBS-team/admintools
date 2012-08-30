class Event < ActiveRecord::Base
  has_many :event_admins, :dependent => :delete_all
  has_many :admins, :through => :event_admins

  validate :starts_at_is_less_than_ends_at

  accepts_nested_attributes_for :event_admins
  attr_accessor :send_to_admins

  scope :before, lambda {|end_time| where("ends_at < ?", Event.format_date(end_time))}
  scope :after, lambda {|start_time| where("starts_at > ?", Event.format_date(start_time))}
  scope :sending_event, lambda { where("send_at < ?", Time.zone.now).where("send_at > ?", Time.zone.now - 2.month).where(:sended => false) }

  def as_json(options = {})
    {
        :id => self.id,
        :title => self.title,
        :description => self.description || "",
        :start => starts_at,
        :end => ends_at,
        :allDay => self.all_day,
        :recurring => false,
        :url => Rails.application.routes.url_helpers.event_path(id)
    }

  end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  before_update do
    unless self.ends_at
      self.ends_at=self.starts_at.end_of_day
    end
  end

  def starts_at_is_less_than_ends_at
    if self.ends_at
      errors.add(:starts_at, "should be less than ends_at") if (starts_at > ends_at)
    end
  end

end
