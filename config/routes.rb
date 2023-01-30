Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'users/registrations', 
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :admin do
    resources :posts

    root to: 'posts#index'
  end

  resources :journals, only: [:index, :show] do
    resources :posts, only: [:show]
  end

  namespace :user do
    resource :profile, controller: :profile, only: [:show, :edit, :update]
    resources :journals do
      resources :posts, except: [:index]
    end
  end

  root 'home#index'
end
