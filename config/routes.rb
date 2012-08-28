Supermanager::Application.routes.draw do
  
  resources :announcements

  resources :contestants
  get "/sign_up" => "contestants#new", as: :sign_up

  # get "/login" => "login_keys#new", as: :login
  # post "/login/request" => "login_keys#create", as: :request_login
  # get "/login/verify/:key" => "login_keys#verify", as: :login

  # post "/login" => "sessions#create"
  # delete "/logout" => "sessions#destroy"

  get "/announcements" => "pages#rules", as: :announcements
  get "/players" => "pages#rules", as: :players
  get "/rules" => "pages#rules", as: :rules
  
  get "/contact" => "pages#rules", as: :contact

  root :to => 'pages#home'
end
