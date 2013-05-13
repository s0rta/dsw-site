Denverstartupweek::Application.routes.draw do

  resources :submissions, only: [ :index, :new, :create ], path: 'panel-picker', path_names: { new: 'submit' }
  resources :newsletter_signups, only: :create
  get '/auth/:provider/callback', to: 'sessions#create'
  mount Cmsimple::Engine => '/'

end
