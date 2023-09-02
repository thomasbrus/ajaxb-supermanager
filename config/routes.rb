Rails.application.routes.draw do
  constraints(host: /supermanager.thomasbrus.nl/) do
    match '/(*path)' => redirect { |params, req| "http://www.ajaxb-supermanager.nl/#{params[:path]}" }, :via => %i[get post]
  end

  resources :clubs do
    resources :players
  end

  get '/players' => 'players#index'
  get '/clubs' => 'clubs#index'
  get '/coaches' => 'coaches#index'

  post '/update_superteam' => 'superteams#update'
  post '/validate_superteam' => 'superteams#validate'
  get '/my_superteam' => 'superteams#edit'
  get '/superteam' => 'superteams#show'

  resources :announcements
  resources :contestants
  resources :login_requests
  resources :messages

  resources :weekly_rankings, only: %i[index show new create edit update destroy]

  get '/export_contestants' => 'contestants#export'

  get '/sign_up' => 'contestants#new', :as => :sign_up
  get '/thank_you' => 'pages#thank_you', :as => :thank_you

  get '/login' => 'login_requests#new', :as => :login
  get '/login/verify/:validation_key' => 'login_requests#verify', :as => :verify_login_request
  get '/login_link_confirmation' => 'pages#login_link_confirmation'
  delete '/logout' => 'sessions#destroy'

  get '/players_list' => 'clubs#index', :as => :players_list
  get '/rules' => 'pages#rules', :as => :rules

  get '/contact' => 'messages#new', :as => :contact

  root to: 'pages#home'
end
