Rails.application.routes.draw do
# devise
  devise_for :users, :controllers => {
    :registrations => 'users/registrations'
  }
# Home Controller
  root  'homes#top'
  get 'home/about' => 'homes#show'
  get 'search' => 'search#search'
# books,users,post_comments,favorites
  resources :users, only: [:index, :show, :edit, :update] do
  	member do
  		get :following, :followers
  	end
  end
  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
