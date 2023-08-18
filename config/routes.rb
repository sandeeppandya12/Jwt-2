Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "/login", to: "sessions#login"
  post "/signup", to: "sessions#signup"
  patch "/update", to: "users#update"
  delete "/destroy", to: "users#destroy"
  post "/change_password", to:"users#change_password"
  post "/forgot_password", to: "users#forgot_password"
  get "/index", to: "users#index"

end
