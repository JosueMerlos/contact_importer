Rails.application.routes.draw do
  get 'contacts/index'
  # root 'home#index'
  devise_for :users

  resources :user_files, only: [:index, :new, :edit, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
