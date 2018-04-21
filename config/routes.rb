Rails.application.routes.draw do
  resources :todos do
    resources :tasks
  end
end
