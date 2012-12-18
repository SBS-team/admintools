module MailerMacros
  def last_email(n = 1)
    ActionMailer::Base.deliveries.last(n)
  end

  def reset_email
    ActionMailer::Base.deliveries = []
  end
end