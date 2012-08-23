class ScheduleEvent
  @queue = :shedule_event

  def self.perform
     Event.includes(:users).sending_event.each do |event|
        event.users.each do |user|
          UserMailer.send_event_email(user).deliver
        end
     end
  end
end