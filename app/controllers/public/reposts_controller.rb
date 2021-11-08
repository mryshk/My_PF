class Public::RepostsController < ApplicationController
  before_action :set_post

  def create
    if Repost.find_by(listener_id: current_listener.id, post_id: @post.id)
      alert :"Already reposted"
    else
      @repost = Repost.create(listener_id: current_listener.id, post_id: @post.id)
    end
  end

  def destroy
    @repost = current_listener.reposts.find_by(post_id: @post.id)
    @repost.destroy
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
