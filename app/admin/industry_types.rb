ActiveAdmin.register IndustryType do
  menu parent: "GiveToo"
  
  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
    end

    f.actions
  end
end
