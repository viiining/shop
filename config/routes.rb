Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'

  namespace :admin, path: "asdfe" do
    get 'dashboard/index'
    resources :books, except: [:show]
    resources :coupons, except: [:show]
  end

  resources :books, only: [:index]

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end
end
