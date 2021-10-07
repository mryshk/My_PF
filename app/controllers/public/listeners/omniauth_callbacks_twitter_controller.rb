# frozen_string_literal: true

class Public::Listeners::OmniauthCallbacksController < Devise::OmniauthCallbacksController








private

  def callback_for(provider)

    @listener = Listener.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @listener, event: :authentication
    set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
  end

  def failure
    redirect_to root_path
  end

end
