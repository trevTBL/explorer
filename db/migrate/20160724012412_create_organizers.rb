class CreateOrganizers < ActiveRecord::Migration
  def change
    create_table :explorer_organizers do |t|
      t.string :name
      t.text :description
      t.string :logo
      t.string :url
      t.string :twitter
      t.string :facebook
      t.string :slug
      t.timestamps null: false
    end

    create_table :explorer_memberships do |t|
      t.belongs_to :user, index: true
      t.belongs_to :organizer, index: true
      t.boolean :owner,null: false, default: false
      t.timestamps null: false
    end

    create_table :explorer_bookings do |t|
      t.belongs_to :user, index: true
      t.belongs_to :event, index: true
      t.timestamps null: false
    end

    add_column :explorer_events, :organizer_id, :integer, index: true
    add_column :explorer_events, :user_id, :integer, index: true
  end
end
