Admintools::Application.routes.draw do

  devise_for :admins


  get "events/search_admins/" => "events#search_admins"

  resources :devices
  resources :rooms
  resources :users
  resources :desktops

  resources :admins
  resources :constructors


  get "/sarg/index" => "sarg#index", :as =>  :sarg_index

  get "events/new/:start/:end/:all_day" => "events#new"
  resources :events

  get "calendar/index", :as => :calendar


  root :to => 'rooms#index'

end
