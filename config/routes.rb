Rails.application.routes.draw do

  if Rails.env.development?
    mount MailPreview => 'mailers'
  end

  devise_for :users, controllers: { registrations: 'users/registrations',
                                    omniauth_callbacks: 'users/omniauth_callbacks' }

  resource :registration, only: [ :new, :create ] do
    collection do
      get :closed
      get :confirm
    end
  end

  resources :submissions, except: [ :edit, :update, :destroy ], path: 'panel-picker', path_names: { new: 'submit' } do
    collection do
      get :thanks
      get :by_day
      get :submissions_closed
      get :feedback_closed
    end
    resources :votes, only: :create
    resources :comments, only: :create
  end

  resources :newsletter_signups, only: :create
  resources :volunteer_signups, only: :create
  resources :sponsor_signups, only: :create

  get '/new-site(/*page)', to: 'new_site#index', as: :new_site, defaults: {page: :index}

  get '/schedule', to: 'schedules#index', as: :schedules
  get '/my-schedule', to: 'schedules#my_schedule', as: :my_schedule
  get '/schedule/:id', to: 'schedules#show', as: :schedule
  post '/schedule/:id', to: 'schedules#create', as: :add_to_schedule
  delete '/schedule/:id', to: 'schedules#destroy', as: :remove_from_schedule
  get '/schedule/:id/feed', to: 'schedules#feed', as: :schedule_feed

  get '/register', to: 'registrations#new', as: :register

  get 'enable-simple-reg', to: 'simple_registrations#enable', as: :enable_simple_reg
  get 'disable-simple-reg', to: 'simple_registrations#disable', as: :disable_simple_reg

  ActiveAdmin.routes(self)

  mount Cmsimple::Engine => '/'

end
