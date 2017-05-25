module Explorer
	module OrganizersHelper

		def valid_org
			org = Organizer.find(params[:id])
			user = current_user
			if user.organizer.exists?(params[:id])
				return true
			else
				return false
			end
				
		end
	end
end