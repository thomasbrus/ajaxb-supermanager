Supermanager::Application.routes.draw do
  
  resources :contestants
  get "/sign_up" => "contestants#new", as: :sign_up

  get "/announcements" => "pages#rules", as: :announcements
  get "/players" => "pages#rules", as: :players
  get "/rules" => "pages#rules", as: :rules
  
  get "/contact" => "pages#rules", as: :contact

  root :to => 'pages#rules'
end
