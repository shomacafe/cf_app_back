Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      namespace :auth do
        resources :sessions, only: [:index]
      end
      resources :projects, only: [:index, :show, :create, :update, :destroy] do
        collection do
          get :index_by_user
        end
        resources :returns, only: [:index, :show, :create, :update]
      end
      resources :users, only: [:index, :show, :update]
      post 'upload_rich_text_image', to: 'rich_text_images#upload_rich_text_image'
    end
  end
end
