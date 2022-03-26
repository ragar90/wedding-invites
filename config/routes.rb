Rails.application.routes.draw do
  root 'invitation#index'
  post "find_guests", to: 'invitation#find_guest', as: :find_guest
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
