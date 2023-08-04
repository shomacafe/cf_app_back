Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :projects, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
