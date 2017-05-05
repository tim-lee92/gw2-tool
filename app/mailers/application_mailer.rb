class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: 'welcome@gw2tool.com', subject: 'Thank you for registering to GW2Tool'
  end

  def send_password_reset_email(user)
    @user = user
    mail to: user.email, from: 'support@gw2tool.com', subject: 'Password Reset Request'
  end
end
