class RemoveCategoriesfromEvents < ActiveRecord::Migration
  def change
  	remove_column :explorer_events, :category
  end
end
