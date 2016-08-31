Rails.application.routes.draw do
  get '/support_requests/update/:id' => 'support_requests#index', as: :update_support_request
  post "/support_requests/:search" => "support_requests#index", as: :search_support_request

  resources :support_requests

  root 'support_requests#index'

end
