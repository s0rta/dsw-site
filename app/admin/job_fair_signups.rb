ActiveAdmin.register JobFairSignup do
  menu parent: "Sessions"

  permit_params :year,
    :company_id,
    :user_id,
    :actively_hiring,
    :number_open_positions,
    :number_hiring_next_12_months,
    :industry_category,
    :organization_size,
    :covid_impact,
    :contact_email,
    :notes

  index do
    selectable_column
    column :year
    column :company do |s|
      s.company.name
    end
    column :user do |s|
      s.user.name
    end
    column :actively_hiring
    column :number_open_positions
    column :number_hiring_next_12_months
    column :industry_category
    column :organization_size
    actions
  end

  controller do
    def scoped_collection
      resource_class.includes(:user, :company)
    end
  end

  # Set a default year filter
  scope("Current", default: true, &:for_current_year)
  scope("Previous Years", &:for_previous_years)

  filter :company_name
  filter :user_name
  filter :actively_hiring
  filter :number_open_positions
  filter :number_hiring_next_12_months
  filter :industry_category
  filter :organization_size

  form do |f|
    f.inputs do
      f.input :year
      f.input :company_id,
        as: :ajax_select,
        data: {
          url: filter_admin_companies_path,
          search_fields: [:name],
          ajax_search_fields: [:company_id]
        }
      f.input :user_id,
        as: :ajax_select,
        data: {
          url: filter_admin_users_path,
          search_fields: %i[name email],
          ajax_search_fields: [:user_id]
        }

      f.input :industry_category, as: :select, collection: JobFairSignup::INDUSTRY_CATEGORIES
      f.input :organization_size, as: :select, collection: JobFairSignup::ORGANIZATION_SIZES
      f.input :contact_email
      f.input :actively_hiring
      f.input :number_open_positions
      f.input :number_hiring_next_12_months
      f.input :covid_impact
      f.input :notes
    end
    f.actions
  end
end
