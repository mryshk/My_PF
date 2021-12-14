class Public::GroupChatsController < ApplicationController
  def create
    # 操作したユーザーのIDを保存したグループチャットテーブル（インスタンス）を作成。
    # その作成したインスタンスにパラメーターにて取得したグループIDとメッセージを保存。
    @chat = current_listener.group_chats.new(chat_params)
    @group = Group.find(params[:group_id])
    @chat_n = GroupChat.new(group_id: @group)
    # 表示するメッセージ
    # グループチャットテーブルから、同グループのメッセージのみ取得。
    @chats = GroupChat.where(group_id: @group)
    @chat.save
  end

  def index
    @group = Group.find(params[:group_id])
    # 上記のグループIDを含むチャットのみ抽出し、@chats変数へ
    @chats = @group.group_chats
    @chat = GroupChat.new(group_id: @group.id)
  end

  # 以下プライベート
  private
  # メッセージ送信時のパラメーター
  def chat_params
    params.require(:group_chat).permit(:message, :group_id)
  end
end
