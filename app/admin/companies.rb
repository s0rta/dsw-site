ActiveAdmin.register Company do
  include ActiveAdmin::AjaxFilter

  menu parent: 'Users', priority: 1

  config.sort_order = 'name_asc'

  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end

  filter :name

  batch_action :combine do |company_ids|
    companies = Company.find(company_ids)
    Company.combine!(*companies)
    redirect_to admin_companies_path
  end

end
