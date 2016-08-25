Rails.application.routes.draw do

  resources :support_requests

  root 'support_requests#index'

end
