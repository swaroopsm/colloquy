class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def attendee_mail(user, body)
    @user = user
    @body  = body
    mail(to: @user.email, subject: 'SCCS Notification Mail')
  end
end
