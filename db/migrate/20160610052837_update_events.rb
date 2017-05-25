class UpdateEvents < ActiveRecord::Migration
  def change
  	remove_column :explorer_events, :date
  	add_column :explorer_events, :event_date, :date
  end
end
