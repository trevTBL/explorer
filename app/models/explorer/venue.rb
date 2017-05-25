module Explorer
	class Venue < ActiveRecord::Base
		has_many :events

		extend FriendlyId
	    friendly_id :slug_candidates, :use => [:slugged,:history, :finders]

		def should_generate_new_friendly_id?
			slug.blank? || name_changed?
		end

		def slug_candidates
			slugger = rand(1..100)
			[
				:name,
				[:name, slugger ]
			]
		end

		validates :name,
			:address1,
			:city,
			:state,
			:zip,
			presence: true

		validates_uniqueness_of :name, scope: [:zip, :city, :state, :address1, :address2], message: "for venue location already exists"

		geocoded_by :full_street_address
		after_validation :geocode
		

		def full_street_address
			[address1, city, state, zip].compact.join(', ')
		end

		def venue_events
			events = Event.where(venue_id: self.id)
			return events
		end

		def nearby_venues
			venues = self.nearbys(30).sample(6)
			return venues
		end

		def nearby_events
			venues = self.nearbys(30)
			ids = venues.map(&:id)
			events = Event.where(venue_id: ids).where(activated: true).sample(6)
			return events
		end

	end
end

