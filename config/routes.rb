Rails.application.routes.draw do
  resources :givers
  resources :takers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'takers/sms', to: "takers#sms"
end
