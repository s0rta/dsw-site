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

ZERISTA_TRACK_IDS = { 'Business'  => 2354,
                      'Design'    => 2356,
                      'Tech'      => 2355,
                      'Manufacturing' => 2357 }

{ 'Business' => 'graph', 'Design' => 'pen', 'Tech' => 'markup', 'Manufacturing' => 'factory' }.each do |track_name, icon|
  t = Track.where(name: track_name).first_or_initialize
  t.icon = icon
  t.zerista_track_id = ZERISTA_TRACK_IDS[track_name]
  t.save!
end

[ 'Government and Technology',
  'Diversity in Technology',
  'Social Impact',
  'Green/Clean Tech',
  'Education' ].each do |name|
  Theme.where(name: name).first_or_create
end

