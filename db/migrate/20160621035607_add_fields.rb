class AddFields < ActiveRecord::Migration
  def change
  	add_column :explorer_events, :category, :string
  	add_column :explorer_events, :image, :string
  	add_column :explorer_events, :address, :string
  	add_column :explorer_events, :city, :string
  	add_column :explorer_events, :state, :string
  	add_column :explorer_events, :zip, :string
  end
end
