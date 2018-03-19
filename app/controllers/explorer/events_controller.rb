require_dependency "explorer/application_controller"

module Explorer
	class EventsController < ApplicationController
		# load_and_authorize_resource
		# skip_authorize_resource :only => :my_events
		# before_action :authenticate_user!, :excerpt => [:show]
		# before_action :authorize_visitor, only: [:new]
		

		def index
			@events = Event.where(activated: true).order(start_date: :ASC)
			@hash = Gmaps4rails.build_markers(@events) do |event, marker|
			  location_link = view_context.link_to 'View events at '+ event.venue.name, venue_path(event.venue)
			  marker.lat event.venue.latitude
			  marker.lng event.venue.longitude

	      marker.infowindow "
					<h4>#{event.venue.name}</h4>
					<p>#{event.venue.address1 }</p>
					<p>#{event.venue.address2 }<br/>
					<p>#{event.venue.city }, #{event.venue.state }, #{event.venue.zip }</p>
					<p><u>#{location_link}</u></p>
				" 
			end
			get_parent
		end

		def new
			@user = current_user
			@event = Event.new
			@organizer = Organizer.new
			@venue = @event.build_venue()
			get_parent
		end

		def create
			@event = Event.new(event_params)
			@event.user_id = current_user.id
			@event.activated = true
			if @event.save
				redirect_to event_path(@event)
			else
				@venue = @event.build_venue() if @event.venue.blank?
			  render action: "new"
		 end
		end

		def show
			@event = Event.find(params[:id])
			@org = @event.organizer
		end

		def edit
			@event = Event.find(params[:id])
			authorize! :update, @event
			venue = @event.build_venue() if @event.venue.blank?
		end

		def update
			@event = Event.find(params[:id])
			if @event.update_attributes(event_params)
				redirect_to event_path(@event)
			else
				venue = @event.build_venue() if @event.venue.blank?
				render action: "edit"
			end
		end

		def destroy
			 @event = Event.find(params[:id])
			 authorize! :delete, @event
			 @event.destroy
			 redirect_to events_path
		end

		def gatekeeper
			@active = Event.where(activated: true).order(start_date: :ASC)
			@inactive = Event.where(activated: false).order(start_date: :ASC)
		end

		

	 	def now
		    @list = Event.where(activated: true).order(start_date: :ASC)
			@events = []

			@list.each do |e|
				if happening_now?(e) == true
					@events << e
				end
			end
	 	end

		def day
			@events = Event.where(activated: true).order(start_date: :ASC)
			@start_time = Date.today
	 		@end_time = 1.day.since(@start_time)
		end

		def week
			@events = Event.where(activated: true).order(start_date: :ASC)
			today = Date.today # Today's date
	        @start_time = today.beginning_of_week(start_day = :sunday)

	 		@end_time = 7.days.since(@start_time)
		end

		def month
			@events = Event.where(activated: true).order(start_date: :ASC)
			today = Date.today # Today's date
	        @start_time = today.beginning_of_month
	 		@end_time = 1.month.since(@start_time)
		end

		def my_events
			@user = current_user
			@events = @user.events.where(activated: true).order(start_date: :ASC)
		end

		def my_tickets
			u = current_user
			@events = u.events.where(activated: true).order(start_date: :ASC)
		end

		private

		def get_parent
        parent = Explorer::Category.where(name: "Event").last
        @event_categories = Explorer::Category.where(parent_id: parent.id)
    end

		def authorize_visitor
			if !user_signed_in?
				redirect_to main_app.join_path and return
			end
		end

		def event_params
			params.require(:event).permit(
				:title,
				:category_id,
				:image,:link,
				:start_date,
				:end_date,
				:start_time,
				:end_time,
				:cost,
				:organizer_id,
				:user_id,
				:description,
				:activated,
				:venue_id,
				:limit,
				:slug,
				:featured,
				:embed,
				:excerpt,
				venue_attributes: 
					[:id,:name,:address1,:address2,:city,:state,:zip,:contact,:phone,:description]
				)
		end

		def happening_now?(e)
			time = e.start_time
			day = e.start_date
			clock = Time.now
			beginning = clock.beginning_of_hour
			ending = clock.end_of_hour
			today = Date.today
	 		tomorrow = 1.day.since(today) 

			if day >=  today && day <= tomorrow
				if time >=  beginning && time <= ending
					return true
				else 
					return false
				end
			end
		end

		def get_valid_events
			@events = Event.where(activated: true).order(start_date: :ASC)
			@valid_events = []

			@events.each do |e|
				if e.is_valid?
					@valid_events << e
				else
					next
				end
			end

			return @valid_events
		end

	 def find_post
	    @event = Event.find params[:id]
	    if request.path != event_path(@event)
	      return redirect_to @event, :status => :moved_permanently
	    end
	  end

	end
end