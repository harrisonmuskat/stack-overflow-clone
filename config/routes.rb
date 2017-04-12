Rails.application.routes.draw do
  root "questions#index"
  resources :questions, except: [:show] do
    resources :answers, except: [:new, :show, :edit, :destroy, :update]
  end

  resources :answers, only: [:update]
end
