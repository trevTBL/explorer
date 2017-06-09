module Explorer
	class Event < ActiveRecord::Base
		# resourcify
		include IceCube
		serialize :schedule, IceCube::Schedule
		# mount_uploader :image, EventUploader
		has_shortened_urls

		extend FriendlyId
	    friendly_id :slug_candidates, :use => [:slugged,:history, :finders]

		NULL_ATTRS = %w( image )
	  	before_save :nil_if_blank

		belongs_to :category

		has_many :bookings
		has_many :users, :through => :bookings

		belongs_to :organizer
		belongs_to :user
		
		belongs_to :venue
		accepts_nested_attributes_for :venue, reject_if: :all_blank

		has_many :groups
		has_many :participants, :through=> :groups

		validates :title,
			:category_id,
			:start_date, 
			:start_time, 
			:link, 
			:description, 
			presence: true

		validates :venue_id, presence: true, :unless => 'venue.present?'

		# validates :excerpt, length: {maximum: 130}
		# validates :description, length: {minimum: 150}

		def nil_if_blank
			NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
		end

		def should_generate_new_friendly_id?
			slug.blank? || title_changed?
		end

		def slug_candidates
			slugger = rand(1..100)
			organizer = self.organizer
			date_d =  self.start_date.strftime("%a") 
			date_m =  self.start_date.strftime("%b") 
			date_dt =  self.start_date.strftime("%d") 
			date_y =  self.start_date.strftime("%Y") 
			[
				:title,
				[:title, date_m, date_dt ],
				[:title, date_m, date_dt, date_y ],
				[:title, date_d, date_m, date_dt, date_y ],
				[:title, date_d, date_m, date_dt, date_y, organizer ],
				[:title, date_d, date_m, date_dt, date_y, organizer, slugger ]
			]
		end


		validate :end_date_after_start
	  validate :end_time_after_start

		def end_date_after_start
		    return if end_date.blank? || start_date.blank?
		    if end_date < start_date
		      self.errors.add(:end_date, "must be after the start date") 
		    end 
		end

		def end_time_after_start
	    return if end_time.blank? || start_time.blank?
	    if start_date == end_date
	      if end_time < start_time
	        self.errors.add(:end_time, "must be after the start time") 
	      end 
	    end
	  end

		def is_active?
		  if self.activated? == true 
		    return true
		  else 
		    return false
		  end
		end

		def is_valid?
	    today = Date.today
	    start_d = today.beginning_of_month
	    end_d = today.end_of_month

		  if self.start_date >= start_d && self.start_date <= end_d
			    return true
			else
				return false
		  end
		end

		def is_valid_this_month?
		    today = Date.today
		    start_d = today.beginning_of_month
		    end_d = today.end_of_month

		  if self.start_date >= start_d && self.start_date <= end_d
			    return true
			else
				return false
		  end
		end

		def is_free?
			if self.cost == '0' || self.cost.blank? || self.cost.downcase == 'free'
				return 'Free'
			else
				return '$' + self.cost.to_s
			end
		end

		def first_day
			return self.start_date.strftime("%a, %b %d") 
		end

		def last_day
			return self.end_date.strftime("%a, %b %d")
		end

		def begins_at
			return self.start_time.strftime("%-I:%M %p")
		end

		def ends_at
			return self.end_time.strftime("%-I:%M %p")
		end

		def event_date
			if first_day == last_day
				return first_day
			else
				return first_day - last_day
			end
		end

		def event_time
			return begins_at - ends_at
		end

		def next
		    self.class.where("id > ?", id).first
		end

		def prev
			self.class.where("id < ?", id).last
		end

		def default_image
	   	if self.category.name == 'Default'
		   	@default_img = ActionController::Base.helpers.asset_path('fallback/default.png')
			elsif self.category.name == 'Hiring'
			   	@default_img = ActionController::Base.helpers.asset_path('fallback/hiring.png')
			elsif self.category.name == 'Networking'
			   	@default_img = ActionController::Base.helpers.asset_path('fallback/networking.png') 
			elsif self.category.name == 'Pitch'
			   	@default_img = ActionController::Base.helpers.asset_path('fallback/pitch.png')
			elsif self.category.name == 'Talks'
			   	@default_img = ActionController::Base.helpers.asset_path('fallback/talks.png')  
			elsif self.category.name == 'Conferences'
			   	@default_img = ActionController::Base.helpers.asset_path('fallback/conferences.png') 
			elsif self.category.name == 'Classes'
			   	@default_img = ActionController::Base.helpers.asset_path('fallback/classes.png')
			elsif self.category.name == 'Diversity'
			   	@default_img = ActionController::Base.helpers.asset_path('fallback/diversity.png')
			elsif self.category.name == 'Presentations'
			   	@default_img = ActionController::Base.helpers.asset_path('fallback/presentations.png')      
			end
		end

	end
end