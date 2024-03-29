Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  post 'signup', to: 'signup#create'
  
  namespace :me, module: 'private' do
    resources :posts
  end
end
