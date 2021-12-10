class Tweet < ApplicationRecord
  belongs_to :user, optional: true
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  enum category_id:{
    "---":0,
    自由民主党・公明党:1, 立憲民主党・国民民主党:2, 日本共産党・れいわ新撰組・社民党:3, 日本維新の会:4,
  }


end
