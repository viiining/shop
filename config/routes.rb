Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  resources :books, except: [:show]
  resources :coupons, except: [:show]

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end
end
