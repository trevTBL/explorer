module Explorer
	class Membership < ActiveRecord::Base
		resourcify
		belongs_to :organizer
		belongs_to :user
	end
end