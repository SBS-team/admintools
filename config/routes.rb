Admintools::Application.routes.draw do

  devise_for :admins

  resources :devices
  resources :rooms
  resources :users
  resources :desktops
  resources :admins
  resources :constructors
  resources :domains


  get "/sarg" => "sarg#index", :as =>  :sarg_index

  get "events/new/:start/:end/:all_day" => "events#new"
  get "local_pings" => "local_pings#index", :as => :local_pings

  constraints(:ip => /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/) do
    get "local_pings/:ip" => "local_pings#show", :as => :local_ping
  end
  
  resources :events

  root :to => 'rooms#index'

end
