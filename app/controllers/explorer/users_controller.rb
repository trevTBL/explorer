require_dependency "explorer/application_controller"

module Explorer
	class UsersController < ApplicationController
		load_and_authorize_resource
		# before_action :authenticate_user!, :only => [:edit, :update, :destroy]
		# before_action :correct_user, :only => [:edit, :update, :destroy]

		def index
			if !current_user.has_role? :admin
				redirect_to root_url and return
			end
		end
		
		def show
			@user = User.find(params[:id])
			@user_events = @user.events.where(activated: true).order(start_date: :ASC)
		end

		def edit
			@user = User.find(params[:id])
		end

		def update
			@user = User.find(params[:id])
			
			if @user.update_attributes(user_params)
				redirect_to user_path(@user)
			else
				render action: "edit"
			end
		end

		private

		def user_params
			params.require(:user).permit(:name)
		end

		def correct_user
			user = User.find(params[:id])
			redirect_to(root_url) unless current_user == user
		end
	end
end