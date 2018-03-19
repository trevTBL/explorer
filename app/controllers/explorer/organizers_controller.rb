require_dependency "explorer/application_controller"

module Explorer
	class OrganizersController < ApplicationController
		load_and_authorize_resource
		# before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
		# before_action :valid_org, :only => [:edit, :update, :destroy]

		def index
			@organizers = Organizer.all
		end

		def new
			@organizer = Organizer.new
		end

		def create
			@organizer = Organizer.new(organizer_params)
			if @organizer.save
				Membership.create(
					organizer_id: @organizer.id, 
					user_id: current_user.id, 
					owner: true
					)
				redirect_to organizer_path(@organizer)
			else
				render action: "new"
			end
		end

		def show
			@organizer = Organizer.find(params[:id])
			@events = @organizer.events.where(activated: true).order(start_date: :ASC)
		end

		def edit
			@organizer = Organizer.find(params[:id])
			authorize! :manage, @organizer
			@membership = Membership.new
		end

		def update
			@organizer = Organizer.find(params[:id])
			if @organizer.update_attributes(organizer_params)
				redirect_to organizer_path(@organizer)
			else
				render action: "edit"
			end
		end

		def destroy
			 @organizer = Organizer.find(params[:id])
			 authorize! :delete, @organizer
			 @organizer.destroy
			 redirect_to organizers_path
		end

		private
		def organizer_params
			params.require(:organizer).permit(
				:name,
				:description,
				:slug,
				:url,
				:twitter,
				:facebook,
				:logo,
				listing_attributes: 
	        [ 
	          :name,
	          :slug,
	          :url,
	          :city,
	          :state,
	          :zip,
	          :organizer_id,
	          :category_id,
	          :latitude,
	          :longitude,
	        ]
				)
		end

		def valid_org
			org = Organizer.find(params[:id])
			user = current_user
			redirect_to(user_path(current_user)) unless user.organizers.exists?(org)	
			# flash[:alert] = "You do not have authorization to complete that action"	
		end
	end
end