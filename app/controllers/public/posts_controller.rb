class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.listener_id = current_listener.id
    @post.save
    redirect_to posts_path
  end

  def show
    @post = Post.find(params[:id])
    @post_comment_n = PostComment.new
    @comments = @post.post_comments
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.listener_id = current_listener.id
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @search = Post.search(params[:keyword]).page(params[:page]).reverse_order
    @keyword = params[:keyword]
    render "search"
  end

  def order
    order = params[:keyword]
    @posts = Post.sort(order)
    render 'index'
  end

  private

  def post_params
    params.require(:post).permit(:post_url, :post_tweet, :picture)
  end
end
