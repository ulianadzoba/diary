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

  post 'tinymce_pictures', to: 'tinymce_pictures#create'

  namespace :user do
    resource :profile, controller: :profile, only: [:show, :edit, :update]
    resources :notifications, only: [:index, :show] do
      collection do
        get :mark_all_as_read
      end
    end
    resources :journals do
      member do
        get :new_author
        post :assign_author
      end
      resources :posts, except: [:index] do
        member do
          get :delete_audio
        end
      end
    end
  end

  root 'home#index'
end
