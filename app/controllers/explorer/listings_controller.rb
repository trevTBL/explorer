require_dependency "explorer/application_controller"

module Explorer
  class ListingsController < ApplicationController
    before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

    def index
        @Listings = Listing.all
    end

    def show
        @listing = Listing.find(params[:id])
    end

    def new
        @listing = Listing.new 
        get_organizers
        get_parent
    end
        

    def create
        @listing = Listing.new(listing_params)
        if @listing.save
            if !@listing.organizer.blank?
                @listing.name = @listing.organizer.name
                @listing.url = @listing.organizer.url
                @listing.save
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
        authorize! :update, @listing
        get_organizers
        get_parent
    end

    def update
        @listing = Listing.find(params[:id])
        if @listing.update_attributes(listing_params)
            redirect_to @listing
        else
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
    def get_parent
        parent = Category.where(name: "Organizer").last
        @organizer_categories = Category.where(parent_id: parent.id)
    end

    def get_organizers
        @organizers = Explorer::Organizer.eager_load(:listing).merge(Explorer::Listing.where(id: nil))
    end

    def listing_params
        params.require(:listing).permit(
            :name,
            :description,
            :slug,
            :url,
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
