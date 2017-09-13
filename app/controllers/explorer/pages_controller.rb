require_dependency "explorer/application_controller"

module Explorer
	class PagesController < ApplicationController
		load_and_authorize_resource
		
		def index
			@users = User.all
		end

		def grid
			@events = Event.all
		end

		def more
			@events = Event.all
		end

		def newsletter
			# gb = Gibbon::Request.new
			# gb.lists(list_id).members.create(
			# 	body: {
			# 		email_address: "foo@bar.com", 
			# 		status: "subscribed", 
			# 		merge_fields: 
			# 			{
			# 				FNAME: "First Name",
			# 				LNAME: "Last Name"
			# 			},
			# 			:double_optin => false
			# 		}
			# 	)
		end

		def user_params
			params.require('explorer/pages').permit(:name, :email, :password)
		end
	end
end