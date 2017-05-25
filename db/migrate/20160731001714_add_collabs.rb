class AddCollabs < ActiveRecord::Migration
  def change
  	create_table :explorer_participants do |t|
      t.string :fname
      t.string :lname
      t.string :logo
      t.string :url
      t.string :twitter
      t.string :facebook
      t.text :image
      t.text :description 
      t.belongs_to :explorer_group, index: true
	    t.belongs_to :explorer_event, index: true
      t.timestamps null: false
    end
  end

  create_table :explorer_group do |t|
	  t.string :name
	  t.text :description
	  t.timestamps null: false
	end
end
