Rails.application.routes.draw do
  resources :todos do
    resources :tasks
  end

  post '/login', to: 'authentication#login'
  post '/signup', to: 'users#create'

  root to: 'todos#index'
end
