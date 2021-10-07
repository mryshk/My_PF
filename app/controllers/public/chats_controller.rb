class Public::ChatsController < ApplicationController
  def show
    @listener = Listener.find(params[:id])
    rooms = current_listener.listener_rooms.pluck(:room_id)
    listener_rooms = ListenerRoom.find_by(listener_id: @listener.id, room_id: rooms)

    unless listener_rooms.nil?
      @room = listener_rooms.room
    else
      @room = Room.new
      @room.save
      ListenerRoom.create(listener_id: current_listener.id, room_id: @room.id)
      ListenerRoom.create(listener_id: @listener.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end


  def create
    @chat = current_listener.chats.new(chat_params)
    @room = @chat.room_id
    @chat_n = Chat.new(room_id: @room)
    @chats = Chat.where(room_id: @room)
   @chat.save
  end


  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end
