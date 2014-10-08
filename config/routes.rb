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
  get 'auth/:provider/callback', to: 'oauths#callback' # for use with Github
  get 'auth/:provider',          to: 'oauths#oauth',   as: :auth_at_provider
  get 'auth/failure',            to: 'oauths#failure'

  # ADMIN ROUTES
  # ----------------------------------------------------------------------------
  scope module: 'admin', path: 'adm1nistr8tion', as: 'admin' do
    root to: 'dashboard#show', as: :dashboard
  end

  resources :applications do
    resources :events, only: :index
  end
  resources :events
  get 'feed', to: 'events#index'

  root 'events#index'

end
