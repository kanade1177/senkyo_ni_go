class FavoritesController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.new(tweet_id: @tweet.id)
    if favorite.save
      #いいねされたツイート
      @tweet = favorite.tweet
      #いいねされたら通知を
      @tweet.create_notification_favorite!(current_user)
    end
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    favorite = current_user.favorites.find_by(tweet_id: @tweet.id)
    favorite.destroy
  end
end
