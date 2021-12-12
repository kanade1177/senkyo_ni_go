class User < ApplicationRecord
  has_secure_password

  attachment :image
  has_many :comments
  has_many :tweets
  has_many :favorites, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  # 自分がフォローしているユーザー関係
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower
  # 自分がフォローされているユーザー関係
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following

  # 自分が作った通知関連
  has_many :active_notifications, class_name: "Notification", foreign_key: :visiter_id, dependent: :destroy
  # 自分宛の通知関連
  has_many :passive_notifications, class_name: "Notification", foreign_key: :visited_id, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true, length: { minimum: 1, maximum: 160 }, on: :update

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ?", current_user.id, id, "follow"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end
end
