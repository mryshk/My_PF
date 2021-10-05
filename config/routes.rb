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
   
 end
end
