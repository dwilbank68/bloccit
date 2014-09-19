Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:update]

  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  # get 'posts/edit'
  # resources :posts # - replaces the above four lines
  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create]
    end
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
