Admintools::Application.routes.draw do

  devise_for :admins
  resources :rooms
  resources :users
  root :to => 'rooms#index'
end
