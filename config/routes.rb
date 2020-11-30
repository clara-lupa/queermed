Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'

  resources :providers, only: [:index, :show, :new, :create ] do
    resources :shortlists, only: :create
    resources :reviews, only: [:create, :update, :destroy]
  end

  resources :shortlists, only: :destroy

  resources :conversations, only: [:create, :index, :show] do
    resources :messages, only: [:create, :index]
  end

  get "shortlist", to: "pages#shortlist", as: :shortlists_index
  get "/favorites/:id/provider/:provider_id", to: "shortlists#favorites"
  # how to nest the post request for new conversations? it transmit somehow information about the user who is on the button we have clicked on to the post request. idea: do an insane nesting: /providers/:id/reviews/:id/conversation/new

end
