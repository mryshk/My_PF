class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if listener_signed_in?
      public_root_path
    else
      artist_root_path
    end
  end

  def after_sign_out_path_for(resource)
    public_root_path
  end

end
