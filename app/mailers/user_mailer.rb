class UserMailer < ActionMailer::Base

  default from: "oleg.kotenko@faceit.com.ua"

  def send_event_email(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
    puts "sended to #{user.email}"
  end

end
