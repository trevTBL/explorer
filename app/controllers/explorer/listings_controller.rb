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
        @organizers = Explorer::Organizer.eager_load(:listing).merge(Explorer::Listing.where(id: nil)
    end
        

    def create
        @listing = Listing.new(organizer_params)
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
    end

    private
        def organizer_params
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
