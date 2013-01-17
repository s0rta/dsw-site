Denverstartupweek::Application.routes.draw do

  resources :newsletter_signups, only: :create
  mount Cmsimple::Engine => '/'

end
