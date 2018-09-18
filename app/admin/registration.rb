ActiveAdmin.register Registration do
  belongs_to :user

  permit_params :is_ambassador
end
