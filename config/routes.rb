Rails.application.routes.draw do

  get 'collaborators/index'

  get 'collaborators/show'

  get 'collaborators/new'

  get 'collaborators/edit'

  devise_for :users
  resources :users, only: [:update] do
    post "downgrade"
  end
  
  resources :charges, only: [:new, :create]

  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end

  get 'about' => 'welcome#about'
  # get 'collaborators_edit' => 'collaborators#edit'
  # post 'collaborators_update' => 'collaborators#update'

  root to: 'wikis#index'

  
 
end