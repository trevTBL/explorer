class AddLatitudeAndLongitudeToVenue < ActiveRecord::Migration
  def change
    add_column :explorer_venues, :latitude, :float
    add_column :explorer_venues, :longitude, :float
  end
end
