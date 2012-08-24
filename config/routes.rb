Supermanager::Application.routes.draw do
  
  get "/sign_up" => "pages#rules", as: :sign_up
  get "/announcements" => "pages#rules", as: :announcements
  get "/players" => "pages#rules", as: :players
  get "/rules" => "pages#rules", as: :rules
  
  get "/contact" => "pages#rules", as: :contact

  root :to => 'pages#rules'
end
