class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception # ActionController::InvalidAuthenticityTokenエラー対策
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if listener_signed_in? # リスナー側ログイン後
      root_path # リスナー側トップ画面に遷移
    else
      artist_root_path # クリエイター側ログイン後はマイページに遷移
    end
  end

  def after_sign_out_path_for(resource) # リスナー側ログアウト後
    about_path # About画面に遷移
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name])
  end
end
