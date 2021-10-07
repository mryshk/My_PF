class Public::RelationshipsController < ApplicationController
  def create
    current_listener.follow(params[:listener_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:listener_id])
    redirect_to request.referer
  end

  def followings
    listener = Listener.find(params[:listener_id])
    @listeners = listener.followings
  end

  def followers
    listener = Listener.find(params[:listener_id])
    @listeners = listener.followers
  end

end
