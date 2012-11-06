class AbsentMailer < ActionMailer::Base
  default from: "dmitriy.savran@faceit.com.ua"

  def send_absent_mail(absent)
    @absent=absent
    @user=absent.user
    addresses=User.where(:role=>'manager').select(:email)+User.user_teamleader(@user).select(:email)
    mail(:to => addresses.map(&:email), :subject => "About absent", :template_path => 'teamleader/absent_mailer',:template_name => 'send_absent_mail')
  end
end
