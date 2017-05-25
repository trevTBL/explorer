module Explorer
	class Category < ActiveRecord::Base
	  has_many :events, dependent: :nullify
	  has_many :listings, dependent: :nullify
	end
end