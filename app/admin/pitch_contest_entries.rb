ActiveAdmin.register PitchContest::Entry do

  permit_params :name,
                :video_url,
                :is_active

  index do
    selectable_column
    column :name
    column :is_active
    column(:votes) { |e| e.votes.size }
    actions
  end

  filter :name

  controller do
    def scoped_collection
      resource_class.includes(:votes)
    end
  end
end
