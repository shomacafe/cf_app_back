Rails.application.routes.draw do
  root 'welcome#index'
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        settions: 'api/v1/auth/sessions'
      }
      namespace :auth do
        resources :sessions_user, only: [:index]
      end
      devise_scope :api_v1_user do
        post 'auth/guest_sign_in', to: 'auth/sessions#guest_sign_in'
      end
      put 'profile/update', to: 'profile#update'
      put 'account/update', to: 'account#update'
      resources :projects, only: [:index, :show, :create, :update, :destroy] do
        collection do
          get :index_by_user
          get :recommended
        end
        resources :returns, only: [:index, :show, :create, :update]
      end
      resources :users, only: [:index, :show, :update]
      post 'upload_rich_text_image', to: 'rich_text_images#upload_rich_text_image'
      resources :purchases, only: [:index, :create]
    end
  end
end
