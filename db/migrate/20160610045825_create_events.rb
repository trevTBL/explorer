class CreateEvents < ActiveRecord::Migration
  def change
    create_table :explorer_events do |t|
      t.string :title
      t.date :date
      t.text :description
      t.datetime :time
      t.string :link
      t.string :cost
      t.string :organizer

      t.timestamps null: false
    end
  end
end
