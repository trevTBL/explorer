require_dependency "explorer/application_controller"

module Explorer
	class VenuesController < ApplicationController
		before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
		
		def index
			if !current_user.has_role? :admin
				redirect_to root_url and return
			end
			@venues = Venue.all
		end

		def show
			@venue = Venue.find(params[:id])
			@events = @venue.events.where(activated: true).order(start_date: :ASC)
			@hash = Gmaps4rails.build_markers(@venue) do |venue, marker|
			  location_link = view_context.link_to 'View events at '+ venue.name, venue_path(venue)
			  marker.lat venue.latitude
			  marker.lng venue.longitude
			  marker.infowindow "
	      										<h4>#{venue.name}</h4>
	      										<p>#{venue.address1 }</p>
														<p>#{venue.address2 }<br/>
														<p>#{venue.city }, #{venue.state }, #{venue.zip }</p>
	      									" 
			end
		end

		def new
			@venue = Venue.new
		end

		def create
			@venue = Venue.new(venue_params)
			if @venue.save
				redirect_to @venue
			else
				render 'new'
			end
		end

		def edit
			@venue = Venue.find(params[:id])
			authorize! :update, @venue
		end

		def update
			@venue = Venue.find(params[:id])
			if @venue.update_attributes(venue_params)
				redirect_to @venue
			else
				render action: "edit"
			end
		end

		def destroy
			 @venue = Venue.find(params[:id])
			 authorize! :delete, @venue
			 @venue.destroy
			 redirect_to venues_path
		end

		private

		def venue_params
			params.require(:venue).permit(:name,:address1,:address2,:city,:state,:zip,:contact,:phone,:description)
		end


	end
end