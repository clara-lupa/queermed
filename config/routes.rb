Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :providers, only: [:index, :show, :new, :create ] do
    resources :shortlists, only: :create
    resources :reviews, only: [:create, :update, :destroy]
  end

  resources :shortlists, only: :destroy

  resources :users, only: [] do
    resources :conversations, only: :create
  end

  resources :conversations, only: [:show] do
    resources :messages, only: [:create, :index]
  end

  get "shortlist", to: "pages#shortlist", as: :shortlists_index

  get "/favorites/:id/provider/:provider_id", to: "shortlists#favorites"
  get "inbox", to: "conversations#index", as: :conversations

  mount ActionCable.server => '/cable'

end
