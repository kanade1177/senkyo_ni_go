class User < ApplicationRecord
  
  has_secure_password
  
  attachement :profile
  has_many :tweets
  has_many :favorites
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  #自分がフォローしているユーザー関係
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :follower
  #自分がフォローされているユーザー関係
  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :following
  
  
  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

end
