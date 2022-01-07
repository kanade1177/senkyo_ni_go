class TweetsController < ApplicationController
  before_action :correct_tweet, only: [:edit]
  def new
    @tweet = Tweet.new
  end

  def index
    #includesメソッドによるN+1問題の解決
    @tweets = Tweet.includes([:user]).page(params[:page]).reverse_order.order(created_at: :desc) #降順
  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    @comment = Comment.new
    @comments = @tweet.comments.order(created_at: :desc) #降順
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id

    if @tweet.save
      redirect_to tweets_path
    else
      render :new
    end
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet.id)
    else
      render :edit
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to action: :index
  end

  def category
    @tweets = Tweet.where(category_id: params[:id]).order("created_at DESC")
    @tweet = Tweet.find_by(category_id: params[:id])
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :body, :category_id)
  end

  def correct_tweet
    @tweet = Tweet.find(params[:id])
    unless @tweet.user.id == current_user.id
      redirect_to tweets_path
    end
  end
end
