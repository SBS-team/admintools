Admintools::Application.routes.draw do
  devise_for :admins
  root :to => 'rooms#index'
  resource :rooms


end
