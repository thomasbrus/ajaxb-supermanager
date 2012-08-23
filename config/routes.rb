Supermanager::Application.routes.draw do
  
  get "/sign_up" => "sign_up#contact_info", as: :sign_up
  get "/announcements" => "pages#home", as: :announcements
  get "/players" => "pages#home", as: :players
  get "/rules" => "pages#rules", as: :rules
  
  get "/contact" => "pages#home", as: :contact

  root :to => 'pages#home'
end
