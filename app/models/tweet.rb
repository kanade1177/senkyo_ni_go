class Tweet < ApplicationRecord
  belongs_to :user_params
  has_many :favorites
end
