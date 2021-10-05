Rails.application.routes.draw do
  devise_for :listeners
  root to: 'homes#top'
  
  resources :listeners, only: [:show,:edit,:update] do
    resource :relationships, only:[:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers',as: 'followers'
  end
  
  
 
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
