module Explorer
	module EventsHelper
		
		def social_helper(title,description,short_link,image,twitter_handle)
			tag = social_share_button_tag(
				title,
				:url => short_link, 
				:image => image,
				desc: description, 
				via: twitter_handle
				)
			return tag
		end

	end

end
