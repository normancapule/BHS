Bhs::Application.routes.draw do
  devise_for :users, 
               :controllers => {
                 :registrations => "users/registrations",
                 :sessions => "users/sessions",
                 :passwords => "users/passwords"
               }
  devise_scope :user do
    match 'login' => 'users/sessions#new'
    match 'logout' => 'users/sessions#destroy'
  end

  resources :transactions
  resources :reservations
  resources :customers
  resources :services
  resources :therapists
  resources :pages, :only => [:index, :show] do
    collection do 
      post 'add_reservation'
      post 'update_reservation'
      delete 'delete_reservation'
    end
  end

  root :to => "pages#index"
end
