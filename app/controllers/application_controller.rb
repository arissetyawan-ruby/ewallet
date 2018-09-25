class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected  
    def after_sign_in_path_for(resource)
      sign_in_url = new_user_session_url
      dashboard_path
=begin      if request.referer == sign_in_url
       super
      else
       stored_location_for(resource) || request.referer || root_path
      end
=end
    end

	  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:type])
	  end
end
