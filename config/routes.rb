Rails.application.routes.draw do
  get 'messages/new'
  get 'messages/create'
  get 'messages/index'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :providers, only: [:index, :show]

  resources :conversations, only: [:create, :index, :show] do
    resources :messages, only: [:create, :index]
  end

  # how to nest the post request for new conversations? it transmit somehow information about the user who is on the button we have clicked on to the post request. idea: do an insane nesting: /providers/:id/reviews/:id/conversation/new
end
