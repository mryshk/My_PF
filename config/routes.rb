Rails.application.routes.draw do
  root to: 'homes#top'
  get 'about' => 'homes#about',as: 'about'
  
  devise_for :listeners
  resources :listeners, only: [:show,:edit,:update] do
    resource :relationships, only:[:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers',as: 'followers'
  end
  resources :posts do
    collection do
      get :order
      get :search
      get :search_tag
    end
    resources :post_comments, only: [:index,:create,:edit,:update,:destroy]
    resource :post_favorites, only: [:index,:create,:destroy]
  end
  
  resources :groups do
    resources :group_listeners, only: [:create, :index, :destroy]
  end
  
  resources :chats, only: [:create,:show,:index]
  
  get 'notification' => 'notifications#index',as: 'notifications'
  
  resources :albums, only: [:index,:show]do
    resources :album_musics, only: [:index,:show]do
      resources :music_comments, only: [:index,:create,:edit,:update,:destroy]
      resources :music_favorites, only: [:index,:create,:destroy]
    end
  end
  
  resources :inquiries, only: [:new,:create,:finish]
  
  
  namespace :artist do
   devise_for :creaters
   resources :creaters, only: [:show,:edit,:update]
   resources :albums do
     resources :album_musics do
       resources :music_comments, only: [:index]
     end
   end
 end

  
  
end
  
  
  
 

