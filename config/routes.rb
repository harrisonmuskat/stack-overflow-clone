Rails.application.routes.draw do
  root "questions#index"
  resources :questions, except: [:show] do
    resources :answers, except: [:new, :show, :edit, :destroy, :update]
  end

  resources :answers, only: [:update]
  resources :users, only: [:new, :update, :destroy]

  get "/auth/:provider/callback", to: "sessions#create"
  
  delete '/logout', to: 'sessions#destroy'
end
