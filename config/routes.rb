Rails.application.routes.draw do
  root 'books#index'
  resources :books, except: [:show]
  resources :coupons

  resource :cart, only:[:show, :destroy] do
    collection do
      post :add, path:'add/:id'
    end
  end
end
