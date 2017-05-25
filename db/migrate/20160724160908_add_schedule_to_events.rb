class AddScheduleToEvents < ActiveRecord::Migration
  def change
  	add_column :explorer_events, :schedule, :text
  end
end
