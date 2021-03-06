Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'admin_constraint'

  # USER ROUTES
  # ----------------------------------------------------------------------------
  post   'logout'               , to: 'sessions#destroy',       as: 'logout'
  get    'login'                , to: 'sessions#new',           as: 'login'
  get    'signup'               , to: 'registrations#new',      as: 'signup'
  get    'profile'              , to: 'registrations#edit',     as: 'profile'
  post   'profile'              , to: 'registrations#update',   as: 'update_profile'
  get    'paswords/:token/edit',  to: 'passwords#edit',         as: 'change_password'
  get    'users/:token/activate', to: 'registrations#activate', as: 'activate_user'
  resource  :password,        only: [:new, :create, :edit, :update]
  resources :registrations, except: [:index, :show, :destroy]
  resources :sessions

  # OAUTH ROUTES
  # ----------------------------------------------------------------------------
  # Central ID
  get 'auth/:provider/callback', to: 'oauths#create'
  get 'auth/failure',            to: 'oauths#failure'

  # ADMIN ROUTES
  # ----------------------------------------------------------------------------
  scope module: 'admin', path: 'adm1nistr8tion', as: 'admin' do
    root to: 'dashboard#show', as: :dashboard
    mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new
  end

  # API ROUTES
  # ----------------------------------------------------------------------------
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :events, only: [:index, :show, :create]
    end
  end

  # APP ROUTES
  # ----------------------------------------------------------------------------
  resources :applications do
    resources :events, only: :index do
      get 'search', on: :collection
    end
    resources :users, only: :index do
      post 'manage_membership'
    end
    resources :invites, only: [:create, :update]
    member do
      get  'members'
    end
  end

  resources :events do
    get 'search', on: :collection
  end
  resources :searches

  get 'feed',    to: 'events#index',        as: :feed
  get 'docs',    to: 'pages#documentation', as: :documentation
  get 'about',   to: 'pages#about',         as: :about
  get 'contact', to: 'pages#contact',       as: :contact

  root 'pages#home'
end
