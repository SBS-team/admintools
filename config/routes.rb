Admintools::Application.routes.draw do

  devise_for :admins
  resources :rooms
  resources :users
  resources :desktops
  resources :gadgets
  root :to => 'rooms#index'
end
