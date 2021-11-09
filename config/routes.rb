Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  # 以下リスナー側ルート
  # コントローラー指定にpublicを追加。URLはpublic記述なし。(module)
  scope module: :public do
    root to: 'homes#top' # ルートパス
    get 'about' => 'homes#about', as: 'about' # ログアウト後に開くアプリ紹介ページに使用
    get 'home' => 'homes#home', as: 'home'

    get '/search', to: 'searchs#search'

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
        get :search_genre # ジャンル検索時に使用
        get :search_tag # タグ検索時に使用
      end
      # 投稿コメント
      resources :post_comments, only: [:index, :create, :edit, :update, :destroy,:show] do
        collection do
          post :reply_create
        end
        member do
          delete :reply_destroy
        end
      end
      # 投稿いいね
      resources :post_favorites, only: [:index, :create, :destroy]
      resources :reposts, only:[:index,:create, :destroy]
    end

    # グループ機能CRUD全部
    resources :groups do
      collection do
        get :search # グループ検索
      end
      resources :group_listeners, only: [:create, :index, :destroy] # グループメンバー参加・一覧
      resources :group_chats, only: [:create, :index, :destroy]
    end

    # チャット機能
    resources :chats, only: [:create, :show, :index]

    # 通知機能
    resources :notifications, only: [:index] do
      collection do
        delete :destroy_all
      end
    end

    # お問い合わせ機能
    resources :inquiry, only: [:new, :create] do
      collection do
        post :confirm
        post :back
        get :finish
      end
    end

    # 楽曲アルバム一覧・詳細
    resources :albums, only: [:index, :show] do
      # アルバムの楽曲一覧・詳細
      resources :album_musics, only: [:index, :show] do
      end
    end
  end # リスナー側moduleのエンドポイント

  # 以下クリエイター側ルート
  # URL・コントローラー指定共にartist記述あり。（namespace）
  namespace :artist do # アーティスト（クリエイター側）
    resources :creaters, only: [:new, :create, :show, :edit, :update, :index]
    # アルバム投稿（クリエイター側のみ可）
    resources :albums do
      collection do
        get :search_genre # アルバムジャンル検索
        get :search # アルバム検索
      end
      # 楽曲投稿（クリエイター側のみ可)
      resources :album_musics do
        # コメント一覧確認画面（クリエイター側のみ可）
        resources :music_comments
        resources :music_favorites, only: [:create, :destroy, :index, :show]
      end
    end
  end
end
