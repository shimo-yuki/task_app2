Rails.application.routes.draw do
  devise_for :users
  root 'tasks#index'
  get 'tasks/team_select' => 'tasks#team_select'
  resources :tasks do
    resources :favorites, only: [:create, :destroy]
  end
  resources :comments, only: [:create, :destroy, :edit, :update]
  resources :team_comments, only: [:create, :destroy, :update, :edit]
  get 'favorites' => "favorites#index"
  get 'tasks/:id/assign' => "tasks#assign", as: 'assign'
  resources :users, only: [:show]
  resources :teams do
    resources :user_teams, only: [:create, :destroy, :update, :index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
