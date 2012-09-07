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

  resources :transactions do
    collection do
      post 'refresh_main_table'
      post 'select_customer'
      post 'select_service_time'
      post 'initialize_transaction_modal'
      post 'paid'
      get 'main_table_data'
      get 'customer_table_data'
      get 'service_table_data'
    end
  end
  resources :reservations
  resources :customers
  resources :services
  resources :therapists
  resources :pages, :only => [:index, :show] do
    collection do 
      post 'create_reservation'
      post 'edit_reservation'
      post 'update_reservation'
      delete 'delete_reservation'
    end
  end

  root :to => "pages#index"
end
