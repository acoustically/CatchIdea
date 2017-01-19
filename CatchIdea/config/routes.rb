Rails.application.routes.draw do
  resources :friends
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	match ":controller(/:action(/:id))", via: [ :get, :post, :patch ]
	get "/", to: "friends#index#"
	get "/sign_in", to: "users#sign_in#"
end
