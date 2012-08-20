Admintools::Application.routes.draw do

  devise_for :admins

  resources :devices
  resources :rooms
  resources :users
  resources :desktops
  resources :events

  get "calendar/index", :as => :calendar

  root :to => 'rooms#index'
end
