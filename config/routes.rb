Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :comments
  resources :books do
    resources :comments, controller: 'books/comments'
  end
  resources :reports
  resources :users, only: %i(index show)
end
