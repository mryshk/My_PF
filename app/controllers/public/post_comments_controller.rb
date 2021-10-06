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
    @comment.save

    # create.js用
    @comments = @post.post_comments
    @post_comment_n = PostComment.new
  end

  def edit
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
    @comment = PostComment.find_by(id: params[:id],music_id: params[:post_id])
    @comment.destroy
    @comments = @post.post_comments

    @post_comment_n = PostComment.new
  end

private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
