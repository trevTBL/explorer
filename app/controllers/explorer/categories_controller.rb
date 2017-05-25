require_dependency "explorer/application_controller"

module Explorer
  class CategoriesController < ApplicationController
    before_action :authenticate_user!, :excerpt => [:show]
    
     def index
        @categories = Category.all
      end

      def new
        @category = Category.new
      end

      def create
        @category = Category.new(category_params)
        if @category.save
            redirect_to new_category_path
        else
            render 'new'
        end
      end

      def show
        @category = Category.find(params[:id])
      end

      def edit
        @category = Category.find(params[:id])
        authorize! :update, @category
      end

      def update
        @category = Category.find(params[:id])
        if @category.update_attributes(category_params)
                redirect_to @category
            else
                render action: "edit"
            end
      end

      def destroy
            @category = Category.find(params[:id])
            authorize! :delete, @category
            @category.destroy
            redirect_to categories_path
      end

      def category_params
        params.require(:category).permit(
            :name,
            :parent_id,
            :counter_cache,
            :icon,
            :color,
            :seodescription
            )
      end
  end
end
