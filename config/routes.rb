Admintools::Application.routes.draw do

  devise_for :admins


  get "events/search_users/" => "events#search_users"

  resources :devices
  resources :rooms
  resources :users
  resources :desktops

  resources :admins
  resources :constructors

  #get "/events/:id" => "events#yomanarot"
  resources :events

  get "calendar/index", :as => :calendar

  #get "calendar/popup/:start/:end/:allday"

  root :to => 'rooms#index'

end
