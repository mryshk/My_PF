class Public::PostCommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = PostComment.new(post_comment_params)
    @comment.listener_id = current_listener.id
    @comment.post_id = @post.id
    @comment_post = @comment.post
    if @comment.save
      @comment_post.create_notification_comment!(current_listener, @comment.id)
    end
    # create.js用
    @comments = @post.post_comments
    @post_comment_n = PostComment.new
  end

  def show
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment_n = PostComment.new
    @comments = PostComment.where(reply_comment: @post_comment.id)
  end

  def reply_create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @comment = PostComment.new(post_comment_params)
    @comment.listener_id = current_listener.id
    @comment.post_id = @post.id
    @comment.save!

    @comments = PostComment.where(reply_comment: @post_comment.id)
    @post_comment_n = PostComment.new
  end

  def edit
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find(params[:id])
    @comment = PostComment.find_by(id: params[:id])
  end

  def update
    @comment = PostComment.find_by(id: params[:id])
    @comment.listener_id = current_listener.id
    @comment.update(post_comment_params)
    redirect_to post_path(@comment.post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
    @comments = @post.post_comments

    @post_comment_n = PostComment.new
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment,:reply_comment)
  end
end
