class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
		if current_user.attendee?
			attendee_index_path
		else
			root_path
		end
  end

end
