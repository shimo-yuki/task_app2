Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index'
  # get 'tasks/set_tasks' => 'tasks#set_tasks'
  resources :tasks do
    resources :favorites, only: [:create, :destroy]
  end
  resources :projects do
    resources :members, only: [:create, :destroy, :update, :index]
    resources :tasks, only: [:new]
  end

  scope module: :task do
    resources :tasks do
      resources :comments, only: [:create, :destroy, :edit, :update]
    end
  end
  scope module: :project do
    resources :projects do
      resources :comments, only: [:create, :destroy, :edit, :update]
    end
  end

  get 'favorites' => "favorites#index"
  resources :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
