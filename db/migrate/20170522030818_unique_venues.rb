class UniqueVenues < ActiveRecord::Migration
  def change
  	add_index :explorer_venues, [:name, :zip, :city, :state, :address1, :address2], unique: true, :name => 'explorer_venue_locations'
  end
end