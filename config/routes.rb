Bhs::Application.routes.draw do
  devise_for :users, 
               :controllers => {
                 :registrations => "users/registrations",
                 :sessions => "users/sessions"
               }
  devise_scope :user do
    match 'login' => 'users/sessions#new'
    match 'logout' => 'users/sessions#destroy'
  end
  root :to => "pages#index"
end
