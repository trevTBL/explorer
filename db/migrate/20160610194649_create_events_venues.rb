class CreateEventsVenues < ActiveRecord::Migration
  def change
    create_table :explorer_events_venues do |t|
      t.references :explorer_event, index: true, foreign_key: true
      t.references :explorer_venue, index: true, foreign_key: true
    end
  end
end
