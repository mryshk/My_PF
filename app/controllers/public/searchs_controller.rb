class Public::SearchsController < ApplicationController
  def search
    @model = params["model"]
    @keyword = params[:keyword]
    @records = search_for(@model, @keyword).page(params[:page]).reverse_order
  end

  private

  def search_for(model, keyword)
    if model == "listener"
      Listener.where(["name LIKE?", "%#{keyword}%"])
    elsif model == "post"
      Post.where(['post_tweet LIKE? OR post_genre LIKE?', "%#{keyword}%", "%#{keyword}%"])
    elsif model == "album"
      Album.where(["name LIKE?", "%#{keyword}%"])
    end
  end
end
