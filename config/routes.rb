Rails.application.routes.draw do
  # root 'home#index'
  root 'contacts#index'
  devise_for :users

  resources :user_files, only: [:index, :new, :show, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
