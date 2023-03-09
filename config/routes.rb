Rails.application.routes.draw do
  scope :users do
    post '', to: 'users#create'
    get 'login', to: 'users#login'
  end

  resources :todos
end
