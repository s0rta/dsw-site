# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless Cmsimple::Page.where(is_root: true).first
  page = Cmsimple::Page.create is_root: true, title: 'Home', template: 'default'
  page.publish!
end

{ 'Business' => 'graph', 'Design' => 'pen', 'Tech' => 'markup', 'Manufacturing' => 'factory', 'Social Enterprise' => 'bulb' }.each do |track_name, icon|
  t = Track.where(name: track_name).first_or_initialize
  t.icon = icon
  t.save!
end

[ 'Government and Technology',
  'Diversity in Technology',
  'Social Impact',
  'Green/Clean Tech',
  'Education' ].each do |name|
  Theme.where(name: name).first_or_create
end

