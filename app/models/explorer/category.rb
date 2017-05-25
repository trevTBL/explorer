module Explorer
	class Category < ActiveRecord::Base
	  has_many :events, dependent: :nullify
	  has_many :listings, dependent: :nullify

	  validates :name, 
            presence: true

	  validates :name, length: { maximum: 140 }

	  scope :with_children, ->() { joins(:children).distinct }
	  scope :top_level, ->() { where(parent_id: nil) }
	  
	  self.per_page = 10

	  # resourcify

	  is_impressionable :counter_cache => true, :unique => [:session_hash]
	  
	  belongs_to :parent, class_name: "Category"
	  has_many :children, class_name: "Category", foreign_key: :parent_id
	  has_many :articles

	  extend FriendlyId
	    friendly_id :slug_candidates, :use => [:slugged,:history, :finders]

	    def slug_candidates
	      slugger = rand(1999..9999)
	      [
	        [:name],
	        [:name, slugger]
	      ]
	    end

	  def should_generate_new_friendly_id?
	    slug.blank? || name_changed?
	  end

	  # before_save :ensure_one_root

	  ##
	  # CLASS METHODS
	  ##

	  def self.root
	    self.top_level.first
	  end

	  def self.make_root(other)
	    self.transaction do
	      old_root = self.root
	      old_root.update_column(:parent_id, other.id)
	      other.update_column(:parent_id, nil)
	    end
	  end

	  ##
	  # INSTANCE METHODS
	  ##

	  def siblings
	    if parent
	      parent.children.where.not(id: self.id)
	    else
	      Explorer::Category.top_level.where.not(id: self.id)
	    end
	  end

	  def has_parent?
	    self.parent.present?
	  end

	  def is_leaf?
	    self.children.empty?
	  end

	  def is_root?
	    self.parent.nil?
	  end

	  def make_root
	    self.class.make_root(self)
	  end

	  private

	  def ensure_one_root
	    return false if self == self.class.root
	    self.parent = self.class.root if parent_id.nil?
	  end
	end
end