class ChatsController < ApplicationController
  def show
   @user = User.find(params[:id])
   rooms = current_user.user_rooms.pluck(:room_id)
   user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
  #チャットルームの有無の確認
  if user_rooms.nil?
   @room = Room.new
   @room.save
   #ユーザーの確認
   UserRoom.create(user_id: @user.id, room_id: @room.id)
   UserRoom.create(user_id: current_user.id, room_id: @room.id)
  else
   @room = user_rooms.room
  end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    if @chat.save
     @room = @chat.room
     @room.create_notification_chat!(current_user)
    end
  end


  private

   def chat_params
    params.require(:chat).permit(:message, :room_id)
   end

end

