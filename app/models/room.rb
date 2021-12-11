class Room < ApplicationRecord
  has_many :chats
  has_many :user_rooms
  has_many :notifications, dependent: :destroy

  def create_notification_chat!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ?", current_user.id, id, "chat"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: "chat"
      )
      if notification.visiter_id == notification.visited_id
                notification.checked = true
      end

      notification.save if notification.valid?
    end
  end

end
