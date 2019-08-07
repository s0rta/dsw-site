ActiveAdmin.register Venue do
  menu parent: "Sessions"

  permit_params :contact_email,
    :contact_name,
    :contact_phone,
    :description,
    :name,
    :address,
    :suite_or_unit,
    :city,
    :state,
    :seated_capacity,
    :standing_capacity,
    :av_capabilities,
    :extra_directions,
    :company_id,
    venue_adminships_attributes: [
      :id,
      :user_id,
      :_destroy,
    ]

  index do
    selectable_column
    column :name
    column :contact_name
    column :contact_email
    column :seated_capacity
    column :standing_capacity
    column :company
    column "Admins" do |venue|
      venue&.admins
    end
    actions
  end

  filter :name
  filter :contact_name
  filter :contact_email
  filter :seated_capacity
  filter :standing_capacity

  form do |f|
    f.inputs do
      f.input :name
      f.input :description, hint: "This will not be displayed publicly"
      f.input :address
      f.input :suite_or_unit
      f.input :city
      f.input :state
      f.input :seated_capacity
      f.input :standing_capacity
      f.input :av_capabilities
      f.input :extra_directions, hint: "These will be displayed to the public next to the address"
      f.input :contact_name
      f.input :contact_email, hint: "Multiple addresses are allowed; separate them with commas"
      f.input :contact_phone
      f.input :company_id,
        as: :ajax_select,
        data: {
          url: filter_admin_companies_path,
          search_fields: [:name],
          ajax_search_fields: [:company_id],
        }

      f.has_many :venue_adminships, allow_destroy: true do |adminship|
        adminship.input :user_id,
          as: :ajax_select,
          collection: [],
          data: {url: filter_admin_users_path, search_fields: %i[name email]}
      end
    end
    f.actions
  end

  controller do
    def scoped_collection
      resource_class.includes(:venue_availabilities)
    end

    def show
      @venue_availabilities = resource.venue_availabilities.for_current_year
      show!
    end
  end

  show do
    tabs do
      tab :details do
        attributes_table(*(default_attribute_table_rows - [:proposed_updates]))
      end

      tab :schedule do
        panel "Schedule" do
          table_for venue_availabilities.order(day: :asc, time_block: :asc) do
            column "Year", sortable: true, &:year
            column "Date Time", sortable: true, &:human_date_time
            column "Title", &:submission
          end
        end
      end
    end
  end
end
