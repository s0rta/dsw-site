Denverstartupweek::Application.routes.draw do

  resources :newsletter_signups, only: :create
  get '/auth/:provider/callback', to: 'sessions#create'
  mount Cmsimple::Engine => '/'

end
