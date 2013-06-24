Denverstartupweek::Application.routes.draw do

  ActiveAdmin.routes(self)

  resources :submissions, only: [ :index, :new, :create ], path: 'panel-picker', path_names: { new: 'submit' } do
    collection do
      get :thanks
      get :voting
    end
  end
  resources :newsletter_signups, only: :create
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  mount Cmsimple::Engine => '/'

end
