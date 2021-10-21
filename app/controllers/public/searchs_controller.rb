class Public::SearchsController < ApplicationController
  def search
    @model = params["model"]
    @keyword = params[:keyword]
    @records = search_for(@model, @keyword)
    # メニュー用
    # 自分の所属するグループを全て集める。
    mygroup_ids = current_listener.group_listeners.pluck(:group_id)
    @mygroups = Group.where(id: mygroup_ids)
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
