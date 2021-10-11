# frozen_string_literal: true

class Public::Listeners::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback_for(:google)
  end

  def twitter
    callback_for(:twitter)
  end

  def facebook
    callback_for(:facebook)
  end

  def callback_for(provider)
    provider = provider.to_s
    @listener = Listener.find_or_create_for_oauth(request.env["omniauth.auth"])
    sign_in_and_redirect @listener, event: :authentication
    set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end
end
