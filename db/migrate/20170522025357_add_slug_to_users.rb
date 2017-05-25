class AddSlugToUsers < ActiveRecord::Migration
  def change
    add_column :explorer_venues, :slug, :string
  end
end
