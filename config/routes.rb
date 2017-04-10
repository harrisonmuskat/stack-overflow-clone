Rails.application.routes.draw do
  root "questions#index"
  resources :questions, :answers
end
