class Event < ActiveRecord::Base
  attr_accessible :title, :starts_at, :ends_at, :all_day, :description
  has_many :event_users
  validate :starts_at_is_less_than_ends_at
  scope :before, lambda {|end_time| {:conditions => ["ends_at < ?", Event.format_date(end_time)] }}
  scope :after, lambda {|start_time| {:conditions => ["starts_at > ?", Event.format_date(start_time)] }}

  # need to override the json view to return what full_calendar is expecting.
  # http://arshaw.com/fullcalendar/docs/event_data/Event_Object/
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
