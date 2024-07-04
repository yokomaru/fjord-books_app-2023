Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :comments, only: %i(edit update destroy)
  resources :books do
    resources :comments, controller: 'books/comments', only: :create
  end
  resources :reports do
    resources :comments, controller: 'reports/comments', only: :create
  end
  resources :users, only: %i(index show)
end
