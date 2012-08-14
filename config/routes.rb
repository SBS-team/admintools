Admintools::Application.routes.draw do

  devise_for :admins
  resources :rooms
  resources :users
  resources :desktops
  root :to => 'rooms#index'

end
