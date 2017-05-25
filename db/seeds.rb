# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Users
User.create!(name:  "Geek All Week",
             email: "geek@techwhileblack.com",
             password:              "changemeyo",
             password_confirmation: "changemeyo",
             admin:     true,
             confirmed_at: Time.zone.now
             )

Category.create!(
  name:  'Business'
)
Category.create!(
  name:  'Career'
)
Category.create!(
  name:  'Class'
)
Category.create!(
  name:  'Conference'
)
Category.create!(
  name:  'Default'
)
Category.create!(
  name:  'Demonstration'
)
Category.create!(
  name:  'Networking'
)
Category.create!(
  name:  'Other'
)
Category.create!(
  name:  'Presentation'
)
Category.create!(
  name:  'Talk'
)
Category.create!(
  name:  'Youth'
)

