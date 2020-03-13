Rails.application.routes.draw do
  resources :users
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :usertypes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
