Rails.application.routes.draw do

  get 'helpscout_hooks/show'

  get '/assets', to: redirect('/contact/assets')

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

  resources :submissions, except: [:destroy ], path: 'panel-picker', path_names: { new: 'submit' } do
    collection do
      get :thanks
      get :by_day
      get :submissions_closed
      get :feedback_closed
      get :mine
      get :search
      get 'track/:track_name', action: :track, as: :track
    end
    resources :votes, only: :create
    resources :comments, only: :create
  end

  resource :volunteership, path: 'volunteer', path_names: { new: 'signup' }

  resources :newsletter_signups, only: :create
  resources :general_inquiries, only: :create
  resources :sponsor_signups, only: :create

  get '/schedule', to: 'schedules#index', as: :schedules
  get '/schedule/:start_day', to: 'schedules#by_day', as: :schedules_by_day, constraints: ->(r) { Submission::DAYS.invert.include?(r.params[:start_day].titleize) }, defaults: { start_day: 'monday', format: 'html' }
  get '/my-schedule', to: 'schedules#my_schedule', as: :my_schedule
  get '/schedule/:id', to: 'schedules#show', as: :schedule
  post '/schedule/:id', to: 'schedules#create', as: :add_to_schedule
  delete '/schedule/:id', to: 'schedules#destroy', as: :remove_from_schedule
  get '/schedule/:id/feed', to: 'schedules#feed', as: :schedule_feed

  get '/register', to: 'registrations#new', as: :register

  get 'enable-simple-reg', to: 'simple_registrations#enable', as: :enable_simple_reg
  get 'disable-simple-reg', to: 'simple_registrations#disable', as: :disable_simple_reg

  post '/helpscout_hook', to: 'helpscout_hooks#create', as: :helpscout_hook

  ActiveAdmin.routes(self)

  get '/(*page)', to: 'new_site#index', as: :page, defaults: { page: :index }
  root to: 'new_site#index'
end
