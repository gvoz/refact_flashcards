Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  filter :locale

  root 'main#index'

  scope module: 'home' do
    resources :user_sessions, only: [:new, :create]
    resources :users, only: [:new, :create]
    get 'login' => 'user_sessions#new', :as => :login

    post 'oauth/callback' => 'oauths#callback'
    get 'oauth/callback' => 'oauths#callback'
    get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  end

  scope module: 'dashboard' do
    resources :user_sessions, only: :destroy
    resources :users, only: [:edit, :update, :destroy]
    get 'password' => 'users#password', as: :password_user
    post 'logout' => 'user_sessions#destroy', :as => :logout
    put "find_flickr"        => "cards#find_flickr"

    resources :cards do
      collection do
        get 'load_form'
        post "load"
      end
    end
    #post "load_cards" => "cards#load_cards", :as => "load_cards"

    resources :blocks do
      member do
        put 'set_as_current'
        put 'reset_as_current'
      end
    end

    put 'review_card' => 'trainer#review_card'
    get 'trainer' => 'trainer#index'
  end
end
