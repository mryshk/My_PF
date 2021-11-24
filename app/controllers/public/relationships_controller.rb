class Public::RelationshipsController < ApplicationController
  def create
    current_listener.follow(params[:listener_id])
    @listener = Listener.find(params[:listener_id])
    @listener.create_notification_follow!(current_listener)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_listener.unfollow(params[:listener_id])
    redirect_back(fallback_location: root_path)
  end

  def followings
    @listener = Listener.find(params[:listener_id])
    @listeners = @listener.followings
  end

  def followers
    @listener = Listener.find(params[:listener_id])
    @listeners = @listener.followers
  end
end
