class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if listener_signed_in? #リスナー側ログイン後
      public_root_path #リスナー側トップ画面に遷移
    else
      artist_root_path #クリエイター側ログイン後はマイページに遷移
    end
  end

  def after_sign_out_path_for(resource) #リスナー側ログアウト後
    about_path #About画面に遷移
  end

end
