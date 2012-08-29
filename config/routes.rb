Supermanager::Application.routes.draw do
  
  resources :announcements

  resources :contestants
  get "/sign_up" => "contestants#new", as: :sign_up
  get "/thank_you" => "pages#thank_you", as: :thank_you

  get "/login" => "login_requests#new", as: :login
  # post "/login/request" => "login_requests#create", as: :request_login
  get "/login/verify/:validation_key" => "login_requests#verify", as: :verify_login_request

  # post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"

  get "/announcements" => "pages#rules", as: :announcements
  get "/players" => "pages#rules", as: :players
  get "/rules" => "pages#rules", as: :rules
  
  get "/contact" => "pages#rules", as: :contact

  root :to => 'pages#home'
end
