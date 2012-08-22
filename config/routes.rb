Bhs::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/login" => "devise/sessions#new"
    delete "/logout" => "devise/sessions#destroy"
  end
  root :to => "pages#index"
end
