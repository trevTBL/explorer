class CreateExplorerListings < ActiveRecord::Migration
  def change
    create_table :explorer_listings do |t|
      t.string :name
      t.string :url
      t.string :slug
      t.string :city
      t.string :state
      t.string :zip
      t.float :latitude
      t.float :longitude
      t.integer  "impressions_count", default: 0
      t.belongs_to :organizer
      t.belongs_to :category


      t.timestamps null: false
    end
  end
end
