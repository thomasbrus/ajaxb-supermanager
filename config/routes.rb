Supermanager::Application.routes.draw do
  
  resources :clubs do
    resources :players
  end

  get "/my_superteam" => "superteams#edit"

  resources :announcements
  resources :contestants
  resources :login_requests
  resources :messages

  get "/sign_up" => "contestants#new", as: :sign_up
  get "/thank_you" => "pages#thank_you", as: :thank_you

  get "/login" => "login_requests#new", as: :login
  get "/login/verify/:validation_key" => "login_requests#verify", as: :verify_login_request
  get "/login_link_confirmation" => "pages#login_link_confirmation"
  delete "/logout" => "sessions#destroy"

  get "/announcements" => "pages#rules", as: :announcements
  get "/players_list" => "clubs#index", as: :players_list
  get "/rules" => "pages#rules", as: :rules
  
  get "/contact" => "messages#new", as: :contact

  root :to => 'pages#home'
end
