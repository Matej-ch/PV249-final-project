Rails.application.routes.draw do

  resources :activities, only: [:index]

  as :user do
    get "/register", to: "devise/registrations#new", as: :register
    get "/login", to: "devise/sessions#new", as: :login
    get "/logout", to: "devise/sessions#destroy", as: :logout
  end

  devise_for :users, skip: [:sessions]

  as :user do
    get "/login", to: "devise/sessions#new", as: :new_user_session
    post "/login", to: "devise/sessions#create", as: :user_session
    delete "/logout", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  resources :user_friendships do
    member do
      put :accept
      put :block
    end
  end
  resources :statuses do
    member do
      put 'like', to: 'statuses#upvote'
      put 'dislike', to: 'statuses#downvote'
    end
  end
  get 'feed', to: 'statuses#index', as: :feed
  root to: 'statuses#index'

  scope ':nick_name' do
    resources :albums do
      resources :pictures
    end
  end

  resources :conversations do
    resources :messages
  end

  get '/:id', to: 'profiles#show', as: 'profile'
end
