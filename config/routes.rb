Rails.application.routes.draw do
  namespace :admin do
    resources:foods,only:[:new,:create,:index,:show,:edit,:update]
    resources:genres,only:[:new,:create,:edit,:update]
    resources:orders,only:[:index,:show,:update]
    resources:order_details,only:[:update]
    resources:customer,only:[:index,:show,:edit,:update]

    get 'homes/top'
  end

  get 'homes/top',as:"top"
  get 'homes/about',as: 'about'

  resources :customer, only: [:show, :edit, :update]
  put "/customer/:id/hide" => "customer#hide", as: 'customer_hide'
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  resources:genres,only:[:new,:create]

  namespace :public do
    resources:cart_foods,only:[:create,:index,:update,:destroy]
    delete :cart_foods, to: 'cart_foods#destroy_all',as:"destroy_all"
    resources:foods,only:[:new,:create,:index,:show,:edit,:update]
    resources:order_details,only:[:create]
  resources :orders, only: [:new, :create, :index, :show] do
        post :confirm, action: :confirm, on: :new
        get "complete"
    end
  end


  resources:addresses,only:[:new,:create,:edit,:update,:destroy]


  get "searches/search",as:"search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
