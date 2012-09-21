Admintools::Application.routes.draw do

  devise_for :admins

  resources :devices
  resources :rooms
  resources :users
  resources :desktops
  resources :admins
  resources :constructors
  resources :domains
  resources :internet_pings, :only => [:index]

  namespace :local_pings do
    resources :subnetworks, :only => [:new, :create, :destroy]
  end

  get "/sarg" => "sarg#index", :as =>  :sarg_index

  get "events/new/:start/:end/:all_day" => "events#new"
  get "local_pings" => "local_pings#index", :as => :local_pings
  get  "local_pings/import" => "local_pings#import", :as => :import_local_pings
  delete "local_pings" => "local_pings#clear", :as => :clear_local_logs

  get  "internet_pings/import" => "internet_pings#import", :as => :import_server_pings
  delete "internet_pings" => "internet_pings#clear", :as => :clear_server_logs

  constraints(:ip => /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/) do
    get "local_pings/:ip" => "local_pings#show", :as => :local_ping
  end

  resources :events

  root :to => 'rooms#index'

end
