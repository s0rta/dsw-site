ActiveAdmin.register SupportArea do
  menu parent: "GiveToo"
  
  permit_params :name,
  :color

  index do
    selectable_column
    column :name
    column :color
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :color, as: :select, collection: SupportArea::COLORS
    end

    f.actions
  end
end
