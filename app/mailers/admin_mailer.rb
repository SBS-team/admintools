class AdminMailer < ActionMailer::Base

  default from: "scheduler@faceit.com.ua"

  def send_event_email(admin)
    @admin = admin
    mail(:to => admin.email, :subject => "Welcome to My Awesome Site")
    puts "sended to #{admin.email}"
  end

end
