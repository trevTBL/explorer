class AddFriendly < ActiveRecord::Migration
  def change
  	add_index :explorer_events, :slug, unique: true
  end
end
