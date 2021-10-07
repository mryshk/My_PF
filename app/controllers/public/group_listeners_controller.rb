class Public::GroupListenersController < ApplicationController

  def create
    @group = Group.find(params[:group_id])
    @group_listener = GroupListener.new(group_id: @group.id)
    @group_listener.listener_id = current_listener.id
    @group_listener.save
    redirect_to group_path(@group)
  end

  def destroy
    @group = Group.find(params[:group_id])
    @group_listener = GroupListener.find_by(group_id: @group.id, listener_id: current_listener.id)
    @group_listener.destroy
    redirect_to group_path(@group)
  end


  def index
    @group = Group.find(params[:group_id])
    @group_listeners = @group.group_listeners
  end

end
