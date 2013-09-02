class WorkshopMailer < ActionMailer::Base

  default from: "sccs@sccs-bng.org"
  helper WorkshopHelper

  def after_registration(r)
  	@registered = r

  	mail(to: r.user.email, subject: 'SCCS Notification Mail')

  end

end
