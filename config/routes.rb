Rails.application.routes.draw do
  root 'homes#top'
  get "home/about" => "homes#about", as: 'about'

  # ① new_user_path を sign_up に合わせる
  get "users/sign_up" => "users#new", as: :new_user
  get "users/sign_up" => "users#new", as: :sign_up

  # ② Sessions
  resource :session, only: [:new, :create, :destroy]
  get "sign_in" => "sessions#new", as: :sign_in

  # ③ Users（ここで new を含めない）
  resources :users, only: [:create, :index, :show, :edit, :update]

  # ④ Books
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy]

  # ⑤ Password reset
  resources :passwords, param: :token
end
