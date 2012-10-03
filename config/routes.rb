Admintools::Application.routes.draw do

  devise_for :admins

  resources :devices
  resources :rooms
  resources :users
  resources :desktops

  resources :admins
  resources :constructors


  get "/sarg" => "sarg#index", :as =>  :sarg_index
  post "/sarg/folder_create" => "sarg#folder_create", :as =>  :sarg_folder_create

  get "events/new/:start/:end/:all_day" => "events#new"
  resources :events

  root :to => 'rooms#index'

end
