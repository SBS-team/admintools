module ScheduleLocalPing
  @queue = :scheduler_local_ping
  def self.perform()
    Ping.multiecho Desktop.all
    # DEBUG
    puts "\n\n"
  end
end