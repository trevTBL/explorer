class AddVenueToEvents < ActiveRecord::Migration
  def change
  	add_column :explorer_events, :venue_id, :integer
  end
end
