class CreateVenues < ActiveRecord::Migration
  def change
    create_table :explorer_venues do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :contact
      t.string :phone
      t.text :description

      t.timestamps null: false
    end
   
  end
end
