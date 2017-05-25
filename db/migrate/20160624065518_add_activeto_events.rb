class AddActivetoEvents < ActiveRecord::Migration
  def change
  	add_column :explorer_events, :activated, :boolean, null: false, default: false
  end
end
