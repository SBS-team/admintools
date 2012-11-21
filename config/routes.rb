Admintools::Application.routes.draw do

  devise_for :users, :path => 'teamleader'
  devise_for :admins, :path => 'admin'

  namespace :teamleader do
    root :to => 'users#index'
    resources :absents
    match "/birthday" => "users#birthday", :as => 'birthday'
    get "/teamleader_users"=>"users#teamleader_users", :as=>:show_users
    resource :skills do
      get :show_list, :on => :member
    end
    get "skills/restore/:id" => "skills#restore", :as => :restore_skills
    delete "skills/delete/:id" => "skills#destroy", :as => :delete_skills

    resources :users, :except => [:new, :create, :destroy] do
      get "/skills" => "skills#show", :as => :skill_list_show
      resource :skills
      member do
        get :edit_password
        put :update_password
      end
    end
    resources :user_changes, :only => [:index, :show]
    resources :reports do
      member do
        put :teamleader_mail_send
      end
    end
    resources :poll
    get "departments/restore/:id" => "departments#restore", :as => :restore_department
    resources :departments
    resources :dashboard, :only => [:index]
    post 'poll/voted' => 'poll#voted', :as => 'voted'
    resources :rooms, :only => [:index]
  end

  namespace :admin do

    root :to => 'rooms#index'

    resources :devices
    resources :rooms
    resources :users do
      resource :skills, :only => [:show, :edit, :update]
    end
    resources :desktops
    resources :admins
    resources :constructors, :except => [:index, :show]
    resources :domains
    resources :internet_pings, :only => [:index]
    resources :events

    namespace :local_pings do
      resources :subnetworks, :only => [:new, :create, :destroy]
    end

    get "tasks"               => "tasks#index",           :as => :show_tasks
    put "tasks/workers"       => "tasks#start_workers",   :as => :start_workers
    put "tasks/scheduler"     => "tasks#start_scheduler", :as => :start_scheduler
    delete "tasks/workers"    => "tasks#stop_workers",    :as => :stop_workers
    delete "tasks/scheduler"  => "tasks#stop_scheduler",  :as => :stop_scheduler

    get "/sarg" => "sarg#index", :as =>  :sarg_index
    post "/sarg/folder_create" => "sarg#folder_create", :as =>  :sarg_folder_create

    get "rooms/:id/constructor" => "constructors#show", :as => :room_constructor

    get "events/new/:start/:end/:all_day" => "events#new"
    get "local_pings" => "local_pings#index", :as => :local_pings
    get  "local_pings/import" => "local_pings#import", :as => :import_local_pings
    delete "local_pings" => "local_pings#clear", :as => :clear_local_logs

    get  "internet_pings/import" => "internet_pings#import", :as => :import_server_pings
    delete "internet_pings" => "internet_pings#clear", :as => :clear_server_logs

    get "users/restore/:id"     => "users#restore", :as => :restore_user

    constraints(:ip => /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/) do
      get "local_pings/:ip" => "local_pings#show", :as => :local_ping
    end
  end

  root :to => 'teamleader/users#index'
end