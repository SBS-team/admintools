Admintools::Application.routes.draw do

  devise_for :admins
  resources :devices
  resources :rooms
  resources :users
  resources :desktops

  root :to => 'rooms#index'
  match "/designer" => "constructor#designer"
end
