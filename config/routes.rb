Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get 'users/sign_up', to: 'users#new', as: :new_user

  resources :users, except: [:new]

  resources :books
  resource :session, only: [:new, :create, :destroy]
end
