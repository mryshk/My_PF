Rails.application.routes.draw do
  # 以下リスナー側ルート
  # コントローラー指定にpublicを追加。URLはpublic記述なし。(module)
  scope module: :public do
    root to: 'homes#top' # ルートパス
    get 'about' => 'homes#about', as: 'about' # ログアウト後に開くアプリ紹介ページに使用

    # リスナー側のDevise登録
    devise_for :listeners, controllers: {
      sessions: "public/listeners/sessions",
      registrations: "public/listeners/registrations",
      passwords: "public/listeners/passwords",
      omniauth_callbacks: 'public/listeners/omniauth_callbacks',
    }

    # マイページ用に使用
    resources :listeners, only: [:show, :edit, :update] do
      # フォロー機能
      resource :relationships, only: [:create, :destroy]
      # フォロー・フォロワー表示
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    # 投稿用
    resources :posts do
      collection do
        get :order # 並び替え時に使用
        get :search # 投稿検索時に使用
        get :search_tag # タグ検索時に使用
      end
      # 投稿コメント
      resources :post_comments, only: [:index, :create, :edit, :update, :destroy]
      # 投稿いいね
      resource :post_favorites, only: [:index, :create, :destroy]
    end

    # グループ機能CRUD全部
    resources :groups do
      collection do
        get :search # グループ検索
      end
      resources :group_listeners, only: [:create, :index, :destroy] # グループメンバー参加・一覧
    end

    # チャット機能
    resources :chats, only: [:create, :show, :index]

    # 通知機能
    resources :notifications, only: [:index,:destroy_all]

    # お問い合わせ機能
    resources :inquiries, only: [:new, :create, :finish]

    # 楽曲アルバム一覧・詳細
    resources :albums, only: [:index, :show] do
      collection do
        get :search # アルバム検索
      end
      # アルバムの楽曲一覧・詳細
      resources :album_musics, only: [:index, :show] do
        # 楽曲コメント
        resources :music_comments, only: [:index, :create, :edit, :update, :destroy]
        # 楽曲いいね
        resources :music_favorites, only: [:index, :create, :destroy]
      end
    end

  end # リスナー側moduleのエンドポイント



  # 以下クリエイター側ルート
  # URL・コントローラー指定共にartist記述あり。（namespace）
  namespace :artist do # アーティスト（クリエイター側）
    devise_for :creaters # クリエイター側のDevise登録
    root to: "creaters#show"
    resources :creaters, only: [:show, :edit, :update]
    # アルバム投稿（クリエイター側のみ可）
    resources :albums do
      # 楽曲投稿（クリエイター側のみ可)
      resources :album_musics do
      # コメント一覧確認画面（クリエイター側のみ可）
        resources :music_comments, only: [:index]
      end
    end
  end
end
