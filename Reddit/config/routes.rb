Rails.application.routes.draw do
  root to: 'subs#index'
  resources :users, only: [:new, :create, :show]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy
  resources :posts, except: :index
end
