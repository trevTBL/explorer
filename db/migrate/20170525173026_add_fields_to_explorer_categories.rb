class AddFieldsToExplorerCategories < ActiveRecord::Migration
  def change
    add_column :explorer_categories, :parent_id, :integer
    add_column :explorer_categories, :slug, :string
    add_column :explorer_categories, :icon, :string
    add_column :explorer_categories, :color, :string
    add_column :explorer_categories, :seodescription, :text
  end
 
end
