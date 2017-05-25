require_dependency "explorer/application_controller"

module Explorer
	class MembershipsController < ApplicationController
		
		def create
			@membership = Explorer::Membership.new(membership_params)

			if @membership.save
				redirect_to edit_organizer_path(@membership.organizer)
			else
				render action: "new"
			end
		end

		private
		def membership_params
			params.require(:membership).permit(
				:user_id,
				:organizer_id
				)
		end

	end
end