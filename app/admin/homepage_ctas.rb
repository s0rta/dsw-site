# frozen_string_literal: true

ActiveAdmin.register HomepageCta do

  menu parent: 'Site Content', label: 'Homepage Calls-to-Action'

  permit_params :title,
                :subtitle,
                :body,
                :priority,
                :link_text,
                :link_href,
                :is_active,
                :relevant_to_cycle,
                :track_id

  index do
    selectable_column
    column :priority
    column :title
    column :subtitle
    column :is_active
    column :track
    column :relevant_to_cycle
    actions
  end

  filter :title
  filter :track
  filter :is_active
  filter :relevant_to_cycle

  form do |f|
    f.inputs do
      f.input :priority
      f.input :title
      f.input :subtitle
      f.input :body
      f.input :link_text
      f.input :link_href
      f.input :relevant_to_cycle,
              label: 'Show during',
              include_blank: 'All',
              as: :select,
              collection: EventSchedule::CYCLES.map { |c| [ c.to_s.titleize, c ] }
      f.input :track_id, as: :select, collection: Track.all.order(:name)
      f.input :is_active
    end

    f.actions
  end
end
