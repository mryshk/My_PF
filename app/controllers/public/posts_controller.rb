class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.listener_id = current_listener.id
    tag_list = params[:post][:name].split(nil)
    if @post.save
      @post.save_tag(tag_list)
      redirect_back(fallback_location: root_path)
    else
    　redirect_to posts_path
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment_n = PostComment.new
    @comments = @post.post_comments
    impressionist(@post, nil, unique: [:ip_address])
    @post_tags = @post.tags
  end

  def index
    @posts = Post.page(params[:page]).reverse_order
    @post_favorite_rank = Post.find(PostFavorite.group(:post_id).order('count(:post_id) desc').pluck(:post_id))
    @post_impression_rank = Post.all.order(impressions_count: 'DESC').page(params[:page])
    @tag_list = Tag.all
    @post = Post.new
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
    @post_favorite_rank = Post.find(PostFavorite.group(:post_id).order('count(:post_id) desc').pluck(:post_id))
    @post_impression_rank = Post.all.order(impressions_count: 'DESC').page(params[:page])
    render 'index'
  end

  private

  def post_params
    params.require(:post).permit(:post_url, :post_tweet, :picture)
  end
end
