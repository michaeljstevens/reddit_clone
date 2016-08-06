Rails.application.routes.draw do

  root 'home#index'

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :subs do
    post 'subscribe', on: :member
    post 'unsubscribe', on: :member
  end

  resources :posts, except: [:index] do
    resources :comments, only: [:new]
    post 'upvote', on: :member
    post 'downvote', on: :member
  end
  resources :comments, except: [:new] do
    resources :comments, only: [:new]
    post 'upvote', on: :member
    post 'downvote', on: :member
  end
end
