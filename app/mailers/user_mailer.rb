class UserMailer < ActionMailer::Base
  default from: "sccs@sccs-bng.org"
 # reply_to: 'sccs@sccs-bng.org'

  def attendee_mail(user, body)
    @user = user
    @body  = body
    mail(to: @user.email, subject: 'SCCS Notification Mail')
  end

 # for testing olny!
 def test_mail(u, s)
  mail(to: u, subject: s, body: "This is an email from SCCS Notifications.. Workshops have benn scheduled")
 end
end
