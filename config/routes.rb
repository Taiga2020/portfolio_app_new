Rails.application.routes.draw do
  # get 'users/new'
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/help', to: 'static_pages#help'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new' #新しいセッションのページ（ログイン）
  post '/login', to: 'sessions#create' #新しいセッションの作成（ログイン）
  delete '/logout', to: 'sessions#destroy' #セッションの削除（ログアウト）
  post '/guest', to: 'guest_sessions#create' #ゲストログイン
  resources :users
  resources :account_activations, only: [:edit]
end
