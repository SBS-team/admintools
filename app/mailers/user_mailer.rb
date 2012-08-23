class UserMailer < ActionMailer::Base
  default from: "dmitriy.savran@faceit.com.ua"

  def welcome_email(user)
    @user = user
   # @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "bomba needs u")
    p user.email
    p 'SEND'
  end

end
