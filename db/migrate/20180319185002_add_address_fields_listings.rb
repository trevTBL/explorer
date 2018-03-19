class AddAddressFieldsListings < ActiveRecord::Migration
  def change
    add_column :explorer_listings, :street, :string
    add_column :explorer_listings, :unit, :string
    add_column :explorer_listings, :phone, :string
  end
end
