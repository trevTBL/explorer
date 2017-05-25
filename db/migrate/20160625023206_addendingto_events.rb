class AddendingtoEvents < ActiveRecord::Migration
  def change
  	remove_column :explorer_events, :time, :datetime
  	remove_column :explorer_events, :event_date, :date
  	add_column :explorer_events, :start_time, :datetime
  	add_column :explorer_events, :end_time, :datetime
  	add_column :explorer_events, :start_date, :date
  	add_column :explorer_events, :end_date, :date
  	add_column :explorer_events, :limit, :string
  	add_column :explorer_events, :slug, :string
  	add_column :explorer_events, :featured, :boolean, null: false, default: false
  	add_column :explorer_events, :embed, :text
  	add_column :explorer_events, :excerpt, :text
  end
end
