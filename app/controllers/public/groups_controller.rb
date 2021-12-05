class Public::GroupsController < ApplicationController
  # 共通部分をset_groupアクションにまとめた。
  before_action :set_group, only:[:show,:edit,:update,:destroy]
  
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_listener.id
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
  end

  def index
    @groups = Group.page(params[:page]).per(2).reverse_order
    @group_listeners_rank = Group.includes(:listeners).sort { |a, b| b.listeners.size <=> a.listeners.size }

    # メニュー用
    # 自分の所属するグループを全て集める。
    mygroup_ids = current_listener.group_listeners.pluck(:group_id)
    @mygroups = Group.where(id: mygroup_ids)
  end

  def edit
  end

  def update
    @group.update(group_params)
    redirect_to group_path(@group)
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  # 以下プライベート
  private
  # グループ(パラメーターから得たIDから)のレコードを取得。そして、変数@groupへ格納。
  def set_group
    @group = Group.find(params[:id])
  end
  # グループ作成時のパラメーター
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
