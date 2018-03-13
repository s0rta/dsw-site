require 'sidekiq/web'
require 'sidecloq/web'

Rails.application.routes.draw do

  if Rails.env.development?
    mount MailPreview => 'mailers'
  end

  # Helpscout sidebar hook
  get 'helpscout_hooks/show'
  post '/helpscout_hook', to: 'helpscout_hooks#create', as: :helpscout_hook

  # Admin tools
  authenticate :user, ->(u) { u.is_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  ActiveAdmin.routes(self)

  # Redirects for old paths
  get '/assets', to: redirect('/contact/assets')
  get '/faq', to: redirect('/contact/faq')

  get '/resources', to: redirect('/about')
  get '/program', to: redirect('/about')
  get '/program/ambassadors', to: redirect('/about/ambassadors')
  get '/program/clusters', to: redirect('/about/clusters')
  get '/program/previous', to: redirect('/about/previous')
  get '/program/team', to: redirect('/about/team')
  get '/program/tracks', to: redirect('/about/tracks')
  get '/program/youth', to: redirect('/about/youth')
  get '/panel-picker/mine', to: redirect('/dashboard')

  devise_for :users, controllers: { registrations: 'users/registrations' }

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
      get :faq
      get :search
      get 'track/:track_name', action: :track, as: :track
    end
    resources :votes, only: :create
    resources :comments, only: :create
  end

  resource :dashboard, only: :show

  resources :newsletter_signups, only: :create
  resources :general_inquiries, only: :create
  resources :sponsor_signups, only: :create

  get '/schedule', to: 'schedules#index', as: :schedules
  get '/schedule/:year',
      to: 'schedules#index',
      as: :schedules_by_year,
      constraints: { year: /\d{4}/ },
      defaults: { year: Date.today.year }
  get '/schedule/:start_day',
      to: 'schedules#by_day',
      as: :schedules_by_day,
      constraints: ->(r) { Submission::DAYS.invert.include?(r.params[:start_day].titleize) },
      defaults: { start_day: 'monday', format: 'html' }
  get '/schedule/:year/:start_day',
      to: 'schedules#by_day',
      as: :schedules_by_year_by_day,
      constraints: ->(r) { Submission::DAYS.invert.include?(r.params[:start_day].titleize) && r.params[:year] =~ /\d{4}/ },
      defaults: { start_day: 'monday', year: Date.today.year, format: 'html' }
  get '/schedule/:id', to: 'schedules#show', as: :schedule
  post '/schedule/:id', to: 'schedules#create', as: :add_to_schedule
  delete '/schedule/:id', to: 'schedules#destroy', as: :remove_from_schedule
  get '/schedule/:id/feed', to: 'schedules#feed', as: :schedule_feed

  get '/register', to: 'registrations#new', as: :register

  namespace :pitch_contest do
    resources :entries, only: :index do
      resources :votes, only: :create
    end
  end

  resource :company_search, only: %i(show)

  get 'enable-simple-reg', to: 'simple_registrations#enable', as: :enable_simple_reg
  get 'disable-simple-reg', to: 'simple_registrations#disable', as: :disable_simple_reg

  get '/(*page)', to: 'site#index', as: :page, defaults: { page: :index }
  root to: 'site#index'
end
