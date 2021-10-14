class Public::GroupChatsController < ApplicationController
  def create
    @chat = current_listener.group_chats.new(chat_params)
    @group = Group.find(params[:group_id])
    @chat_n = GroupChat.new(group_id: @group)
    @chats = GroupChat.where(group_id: @group)
    @chat.save
  end


  def index
    @group = Group.find(params[:group_id])
    @chats = @group.group_chats
    @chat = GroupChat.new(group_id: @group.id)
  end


  def destroy
  end

  private

  def chat_params
    params.require(:group_chat).permit(:message, :group_id)
  end

end
