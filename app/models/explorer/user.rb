module Explorer
  class User < ActiveRecord::Base
    rolify
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :confirmable, :lockable

    has_many :bookings
    has_many :events, :through => :bookings

    has_many :memberships
    has_many :organizers, :through => :memberships

    has_many :events

    has_and_belongs_to_many :venues

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
    
  end
end