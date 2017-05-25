class AddTwitter < ActiveRecord::Migration
  def change
  	add_column :explorer_events, :twitter, :string
  	add_column :explorer_events, :facebook, :string
  	add_column :explorer_events, :website, :string
  end
end
