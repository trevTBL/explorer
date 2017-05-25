module Explorer
  class Listing < ActiveRecord::Base
  	resourcify
  	belongs_to :organizer
  	belongs_to :category
  	
  	extend FriendlyId
	 	friendly_id :slug_candidates, :use => [:slugged,:history, :finders]

	  def slug_candidates
			slugger = rand(1..100)
			listing = self.name
			[
				listing,
				[listing, slugger ],
				[listing, slugger ]
			]
		end

		def should_generate_new_friendly_id?
			slug.blank? || name_changed?
		end

		geocoded_by :zip
		after_validation :geocode
		

		def full_street_address
			[city, state, zip].compact.join(', ')
		end
  end
end
