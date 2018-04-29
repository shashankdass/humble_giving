Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'takers/sms', to: "takers#sms"
  get 'givers/get_current_lumnes', to:"givers#get_current_lumnes"

  resources :givers
  resources :takers
end
