require_dependency "explorer/application_controller"

module Explorer
  class RegistrationsController < Devise::RegistrationsController
   #  invisible_captcha only: [:new]
  	before_filter :configure_permitted_parameters, if: :devise_controller?
   

    # def new
    #   super
    #   # flash[:info] = 'Registrations are currently closed, please check back soon'
    #   redirect_to beta_invitation_path
    # end

    # def create
    #   @user = build_resource
    #   super
    # end

    # def update
    #   super
    #   @user = resource # Needed for Merit
    # end

    # def destroy
    #   super
    # end

    private

    def send_mail?
      return true
    end

    def account_update_params
      params.require(:user).permit(:name, 
        :email, 
        :password, 
        :avatar,
        :phone,
         address_attributes: 
          [ 
            :id, 
            :line1,
            :line2,
            :city,
            :state,
            :zip,
            :latitude,
            :longitude,
          ]
        )
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end
   

    def after_sign_up_path_for(resource)
      stored_location_for(resource) || root_path
    end

    def after_inactive_sign_up(resource)
     stored_location_for(resource) || root_path
    end



    def after_update_path_for(resource)
      stored_location_for(resource) || root_path
    end
    
  end
end