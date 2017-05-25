class ExplorerCaegoryParent < ActiveRecord::Migration
  def change
  	add_foreign_key :explorer_categories, :explorer_categories, column: :parent_id, primary_key: :id
  	add_index :explorer_categories, :parent_id
  end
end
