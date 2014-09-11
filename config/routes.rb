Rails.application.routes.draw do
  devise_for :users
  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  # get 'posts/edit'

  resources :posts # - replaces the above four lines

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
