Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :lines
      resources :lines_users, only: [:create,:update]
      resources :users


      get 'cu' => 'users#cu'

      get '/users/:id/lines', to: 'users#lines'
      get '/users/:id/created_lines', to: 'users#created_lines'
      get '/lines/:id/users', to: 'lines#users'
    end
  end
end
