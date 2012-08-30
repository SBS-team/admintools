class ScheduleEvent
  @queue = :shedule_event

  def self.perform
     Event.includes(:admins).sending_event.each do |event|
        event.admins.each do |admin|
          AdminMailer.send_event_email(admin, event).deliver
        end
     end
  end
end