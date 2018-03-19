require_dependency "explorer/application_controller"

module Explorer

class Organizer < ActiveRecord::Base
	resourcify
	has_many :memberships
	has_many :users, :through => :memberships

	has_many :events
	has_many :listings

	def smart_add_url_protocol
	  unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
	    self.url = "https://#{self.url}"
	  end
	  unless self.twitter[/\Ahttp:\/\//] || self.twitter[/\Ahttps:\/\//]
	    self.twitter = "https://#{self.twitter}"
	  end
	  unless self.facebook[/\Ahttp:\/\//] || self.facebook[/\Ahttps:\/\//]
	    self.facebook = "https://#{self.facebook}"
	  end
	  unless self.logo[/\Ahttp:\/\//] || self.logo[/\Ahttps:\/\//]
	    self.logo = "https://#{self.logo}"
	  end
	end

	before_save :smart_add_url_protocol

	def to_s
		self.name
	end

	extend FriendlyId
 	friendly_id :slug_candidates, :use => [:slugged,:history, :finders]

    def slug_candidates
		slugger = rand(1..100)
		organizer = self.name
		[
			organizer,
			[organizer, slugger ],
			[organizer, slugger ]
		]
	end

	def should_generate_new_friendly_id?
		slug.blank? || name_changed?
	end
	
end
end