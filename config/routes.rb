Rails.application.routes.draw do
  root to: 'homes#top' #ルートパス
  get 'about' => 'homes#about', as: 'about' #ログアウト後に開くアプリ紹介ページに使用
  
  devise_for :listeners #リスナー用のDevise
  resources :listeners, only: [:show,:edit,:update]do #マイページ用に使用
    resource :relationships, only:[:create,:destroy] #フォロー機能
    get 'followings' => 'relationships#followings', as: 'followings' #フォロー・フォロワー表示
    get 'followers' => 'relationships#followers',as: 'followers'
  end
  
  resources :posts do #投稿用
    collection do
      get :order #並び替え時に使用
      get :search #投稿検索時に使用
      get :search_tag #
    end
    resources :post_comments, only: [:index,:create,:edit,:update,:destroy]
    resource :post_favorites, only: [:index,:create,:destroy]
  end
  
  resources :groups do
    collection do
      get :search
    end
    resources :group_listeners, only: [:create, :index, :destroy]
  end
  
  resources :chats, only: [:create,:show,:index]
  
  get 'notification' => 'notifications#index',as: 'notifications'
  
  resources :albums, only: [:index,:show]do
    collection do
      get :search 
      e
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
  
  
  
 

