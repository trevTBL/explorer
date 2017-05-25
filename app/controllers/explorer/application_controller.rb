module Explorer
  class ApplicationController < ActionController::Base
	  protect_from_forgery with: :exception
	  before_action :configure_permitted_parameters, if: :devise_controller?

	  rescue_from CanCan::AccessDenied do |exception|
	  	exception.default_message = "You don't have permission to do that"
	    respond_to do |format|
	      format.json { head :forbidden }
	      format.html { redirect_to main_app.root_url, :alert => exception.message }
	    end
	  end

	  protected

		def configure_permitted_parameters
		  devise_parameter_sanitizer.permit(:sign_up,keys: [:name])
		  devise_parameter_sanitizer.permit(:account_update,keys: [:name])
		end

		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end

		def after_sign_in_path_for(resource)
	    @user = resource
	    stored_location_for(resource) || my_events_path
	  end
  end
end
