Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show, :update, :index]

  resources :posts, only: [:index]

  resources :topics do
    resources :posts, except: [:index], controller: 'topics/posts' do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]

      post '/up-vote'   => 'votes#up_vote',   as: :up_vote
      post '/down-vote' => 'votes#down_vote', as: :down_vote
    end
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
