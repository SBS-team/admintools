class Event < ActiveRecord::Base
  has_many :event_admins, :dependent => :delete_all
  has_many :admins, :through => :event_admins

  validate :starts_at_is_less_than_ends_at

  accepts_nested_attributes_for :event_admins, :allow_destroy => true
  attr_accessor :send_to_admins, :repeat_events, :event_days, :copy

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
        :url => Rails.application.routes.url_helpers.admin_event_path(id)
    }

  end

  #def original
  #  @original || false
  #end

  def self.format_date(date_time)
    Time.at(date_time.to_i).to_formatted_s(:db)
  end

  before_update do
    unless self.ends_at
      self.ends_at=self.starts_at.end_of_day
    end
  end

  after_create do
    if self.copy.blank?
      self.update_attributes(:group_id => self.id) unless self.repeat_events == ""
      count_of_copies = 9
      if self.repeat_events == "selected days"
        (good_days(self.starts_at.to_date, self.event_days.map(&:to_i), count_of_copies, 1)).each do |day|
          new_event = self.dup
          new_event.update_attributes(:starts_at=>day,
                          :ends_at=>day + (self.ends_at-self.starts_at).to_i.day,
                          :send_at=>day, :group_id => self.id, :copy => true)
          self.event_admins.each{|ea| ea.dup.update_attributes(:event_id=>new_event.id)}
        end
      else
        if self.repeat_events != ""
          (1..count_of_copies).each do |i|
            new_event = self.dup
            new_event.update_attributes(:starts_at=>self.starts_at+i.send(self.repeat_events),
                             :ends_at=>self.ends_at+i.send(self.repeat_events),
                             :send_at=>self.send_at+i.send(self.repeat_events),
                             :group_id => self.id, :copy => true)
            self.event_admins.each{|ea| ea.dup.update_attributes(:event_id=>new_event.id)}
          end
        end
      end

    end
  end

  def starts_at_is_less_than_ends_at
    if self.ends_at
      errors.add(:starts_at, "should be less than ends_at") if (starts_at > ends_at)
    end
  end

  private

  def good_days date, bad_days, count_days, first_day = 0
    add_days = (7 - bad_days.count) * 7 * (count_days / 7+1)
    ((date..(date+count_days+add_days)).select{|day| bad_days.include? day.cwday})[first_day..count_days]
  end
end
