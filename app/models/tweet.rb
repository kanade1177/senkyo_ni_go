class Tweet < ApplicationRecord
  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 1, maximum: 280 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # コメント機能通知
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      tweet_id: id,
      visited_id: user_id,
      action: "comment"
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # いいね通知
  def create_notification_favorite!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and tweet_id = ? and action = ?", current_user.id, user_id, id, "favorite"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        tweet_id: id,
        visited_id: user_id,
        action: "favorite"
      )
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  enum category_id:{
    "---":0,
    自由民主党・公明党:1, 立憲民主党・国民民主党:2, 日本共産党・れいわ新撰組・社民党:3, 日本維新の会:4,
  }


end
