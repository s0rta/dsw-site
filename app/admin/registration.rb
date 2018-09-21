ActiveAdmin.register Registration do
  belongs_to :user

  show do
    tabs do
      tab :details do
        attributes_table(*default_attribute_table_rows)
      end

      tab :schedule do
        panel 'Schedule' do
          table_for registration.submissions.includes(:sponsorship) do
            column(:title, &:full_title)
            column(:time) { |s| "#{s.human_start_day} #{s.human_time_range}".html_safe }
            column(:location, &:human_location_name)
            column { |s| link_to 'View on schedule', schedule_path(s) }
          end
        end
      end
    end
  end
end
