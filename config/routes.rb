Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get 'coupons/index'

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
    member do
      post 'apply_coupon', to: 'carts#apply_coupon'
      delete 'cancel_coupon', to: 'carts#cancel_coupon'
    end
  end
end
