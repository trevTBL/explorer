class CreateCategories < ActiveRecord::Migration
  def change
    create_table :explorer_categories do |t|
      t.string :name
      t.timestamps
    end

    add_reference :explorer_events, :category
  end
end
