# frozen_string_literal: true

ActiveAdmin.register HomepageCta do

  menu label: 'Homepage Calls-to-Action'

  permit_params :title,
                :subtitle,
                :body,
                :priority,
                :link_text,
                :link_href,
                :is_active

  index do
    selectable_column
    column :priority
    column :title
    column :subtitle
    column :is_active
    column :relevant_to_cycle
    actions
  end

  filter :title

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
      f.input :is_active
    end

    f.actions
  end
end
