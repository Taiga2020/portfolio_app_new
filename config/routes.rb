Rails.application.routes.draw do
  # get 'users/new'
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  #下記：アカウント登録(post送信)時にsignup_pathではなくusers_pathに送られていた問題を修正
  post '/signup', to: 'users#create' #追加
  get '/login', to: 'sessions#new' #新しいセッションのページ（ログイン）
  post '/login', to: 'sessions#create' #新しいセッションの作成（ログイン）
  delete '/logout', to: 'sessions#destroy' #セッションの削除（ログアウト）
  post '/guest', to: 'guest_sessions#create' #ゲストログイン
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
