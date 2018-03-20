require_dependency "explorer/application_controller"

module Explorer
  class ListingsController < ApplicationController
    load_and_authorize_resource
    # before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

    def index
        @listings = Listing.all
        @hash = Gmaps4rails.build_markers(@listings) do |listing, marker|
            path = listing.organizer_id ? organizer_path(listing.organizer_id) : listing_path(listing)
            location_link = view_context.link_to listing.name, path
            marker.lat listing.latitude
            marker.lng listing.longitude

            marker.infowindow "
            <h4>#{listing.name}</h4>
            <p>#{listing.city }, #{listing.state}, #{listing.zip }</p>
            <p><u>#{location_link}</u></p>
            " 
        end
    end

    def show
        @listing = Listing.find(params[:id])
    end

    def new
        @listing = Listing.new
        if current_user.has_role? :admin
            @organizers = Explorer::Organizer.all
        else
            @organizers = current_user.organizers
        end
        get_categories
    end
        

    def create
        @listing = Listing.new(listing_params)
        if @listing.save
            if @listing.organizer_id
              redirect_to organizer_path(@listing.organizer) and return
            else
              redirect_to @listing and return
            end
        else
            render 'new'
        end
    end

    def edit
        @listing = Listing.find(params[:id])
        if current_user.has_role? :admin
            @organizers = Explorer::Organizer.all
        else
            @organizers = current_user.organizers
        end
        get_categories
    end

    def update
        @listing = Listing.find(params[:id])
        if @listing.update_attributes(listing_params)
            flash[:success] = "Listing updated"
            redirect_to edit_listing_path(@listing)
        else
            flash[:danger] = "Couldn't save your listing. Please check input."
            render action: "edit"
        end
    end

    def destroy
        @listing = Listing.find(params[:id])
        # authorize! :delete, @listing
        @listing.destroy
        redirect_to listings_path
    end

    private
 
    def get_categories
        parent = Explorer::Category.where(name: "Organizer").last
        @organizer_categories = Explorer::Category.where(parent_id: parent.id)
    end


    def listing_params
        params.require(:listing).permit(
            :name,
            :description,
            :slug,
            :url,
            :phone,
            :street,
            :unit,
            :city,
            :state,
            :zip,
            :organizer_id,
            :category_id,
            :latitude,
            :longitude
        )
    end
  end
end
