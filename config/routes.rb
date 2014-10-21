Rails.application.routes.draw do

  # USER ROUTES
  # ----------------------------------------------------------------------------
  get    'logout'               => 'sessions#destroy',     as: 'logout'
  get    'login'                => 'sessions#new',         as: 'login'
  get    'signup'               => 'registrations#new',    as: 'signup'
  get    'profile'              => 'registrations#edit',   as: 'profile'
  post   'profile'              => 'registrations#update', as: 'update_profile'
  get    'paswords/:token/edit' => 'passwords#edit',       as: 'change_password'
  resource  :password,        only: [:new, :create, :edit, :update]
  resources :registrations, except: [:index, :show, :destroy]
  resources :sessions

  # OAUTH ROUTES
  # ----------------------------------------------------------------------------
  #post '/oauth/request_token',    to: 'oauths#new'
  #get '/auth/:provider/callback', to: 'oauths#callback'
  #get '/auth/failure',            to: 'oauths#failure'

  post 'auth/callback',          to: 'oauths#callback'
  get 'auth/callback',           to: 'oauths#callback'
  get 'auth/:provider/callback', to: 'oauths#callback' # for use with Github
  get 'auth/:provider',          to: 'oauths#oauth',   as: :auth_at_provider
  get 'auth/failure',            to: 'oauths#failure'

  # ADMIN ROUTES
  # ----------------------------------------------------------------------------
  scope module: 'admin', path: 'adm1nistr8tion', as: 'admin' do
    root to: 'dashboard#show', as: :dashboard
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
    resources :events, only: :index
    resources :users, only: :index do
      post 'manage_membership'
    end
    member do
      get  'members'
    end
  end
  resources :events
  resources :searches
  get 'feed', to: 'events#index'
  get 'docs', to: 'pages#documentation', as: :documentation
  get 'home', to: 'pages#home'

  root 'events#index'

end
