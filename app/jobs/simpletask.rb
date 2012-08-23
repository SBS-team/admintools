module MyJob
  @queue = :my_job_queue

  def self.perform
    puts 'its XYNTA1'
    Event.includes(:users).sending_event.each do |event|
     event.users.each do |user|
       UserMailer.welcome_email(user).deliver

     end
    end

  end
end