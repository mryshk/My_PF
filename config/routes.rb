Rails.application.routes.draw do

 #以下リスナー側ルート
 #コントローラー指定にpublicを追加。URLはpublic記述なし。(module)
 scope module: :public do

  root to: 'homes#top' #ルートパス
  get 'about' => 'homes#about', as: 'about' #ログアウト後に開くアプリ紹介ページに使用

  devise_for :listeners, controllers: {
    sessions: "public/listeners/sessions",
    registrations: "public/listeners/registrations",
    passwords: "public/listeners/passwords",
    omniauth_callbacks: 'public/listeners/omniauth_callbacks',
  }

  resources :listeners, only: [:show,:edit,:update]do #マイページ用に使用
    resource :relationships, only:[:create,:destroy] #フォロー機能
    get 'followings' => 'relationships#followings', as: 'followings' #フォロー・フォロワー表示
    get 'followers' => 'relationships#followers',as: 'followers'
  end

  #リスナー側のDevise登録

  resources :posts do #投稿用
    collection do
      get :order #並び替え時に使用
      get :search #投稿検索時に使用
      get :search_tag #タグ検索時に使用
    end
    resources :post_comments, only: [:index,:create,:edit,:update,:destroy] #投稿コメント
    resource :post_favorites, only: [:index,:create,:destroy] #投稿いいね
  end

  resources :groups do #グループ機能CRUD全部
    collection do
      get :search #グループ検索
    end
    resources :group_listeners, only: [:create, :index, :destroy] #グループメンバー参加・一覧
  end

  resources :chats, only: [:create,:show,:index] #チャット機能

  get 'notification' => 'notifications#index',as: 'notifications' #通知機能

  resources :albums, only: [:index,:show]do #楽曲アルバム一覧・詳細
    collection do
      get :search #アルバム検索
    end
    resources :album_musics, only: [:index,:show]do #アルバムの楽曲一覧・詳細
      resources :music_comments, only: [:index,:create,:edit,:update,:destroy] #楽曲コメント
      resources :music_favorites, only: [:index,:create,:destroy] #楽曲いいね
    end
  end
  resources :inquiries, only: [:new,:create,:finish] #お問い合わせ機能

 end #リスナー側moduleのエンドポイント

 #以下クリエイター側ルート
 #URL・コントローラー指定共にartist記述あり。（namespace）
 namespace :artist do #アーティスト（クリエイター側）
   devise_for :creaters #クリエイター側のDevise登録
   root to: "creaters#show"
   resources :creaters, only: [:show,:edit,:update] #
   resources :albums do #アルバム投稿（クリエイター側のみ可）
     resources :album_musics do #楽曲投稿（クリエイター側のみ可）
       resources :music_comments, only: [:index] #コメント一覧確認画面（クリエイター側のみ可）
     end
   end
 end

end





