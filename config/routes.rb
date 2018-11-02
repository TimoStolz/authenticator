Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    devise_scope :user do
      post 'users/login', to: 'sessions#create'
      post 'users', to: 'registrations#create'
    end

    resources :tokens
  end
end
