Admintools::Application.routes.draw do

  devise_for :admins

  get 'events/search_users/'=>'events#search_users'

  resources :devices
  resources :rooms
  resources :users
  resources :desktops
  resources :events

  get "calendar/index", :as => :calendar

  root :to => 'rooms#index'
  match "/designer" => "constructor#designer"
end
