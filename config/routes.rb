Rails.application.routes.draw do

  root to: "homes#top"
  get "home/about" => "homes#about"

  # 認証（Authentication風だけど名前は sign_* 系）
  get    "users/sign_in",  to: "sessions#new",     as: :sign_in
  post   "users/sign_in",  to: "sessions#create"
  delete "users/sign_out", to: "sessions#destroy", as: :sign_out

  # サインアップ
  get  "users/sign_up", to: "users#new",    as: :sign_up
  post "users",         to: "users#create"


  # ユーザー作成・詳細・編集・更新
  resources :users, only: [:create, :show, :edit, :update, :index]

  # パスワード再設定
  resources :passwords, only: [:new, :create, :edit, :update], param: :token

  # 投稿機能
  resources :books, only: [:index, :show, :edit, :update, :destroy, :new, :create]

end
