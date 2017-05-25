class AddFieldsToExplorerCategories < ActiveRecord::Migration
  def change
    add_column :explorer_categories, :parent_id, :string
    add_column :explorer_categories, :slug, :string
    add_column :explorer_categories, :icon, :string
    add_column :explorer_categories, :color, :string
    add_column :explorer_categories, :seodescription, :text
  end
  add_foreign_key :explorer_categories, :explorer_categories, column: :parent_id, primary_key: :id
  add_index :explorer_categories, :parent_id
end
