Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index'
  # get 'tasks/set_tasks' => 'tasks#set_tasks'
  resources :tasks do
    resources :favorites, only: [:create, :destroy]
  end
  resources :comments, only: [:create, :destroy, :edit, :update]
  get 'favorites' => "favorites#index"
  resources :users, only: [:show]
  resources :projects do
    resources :members, only: [:create, :destroy, :update, :index]
    resources :tasks, only: [:new]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
