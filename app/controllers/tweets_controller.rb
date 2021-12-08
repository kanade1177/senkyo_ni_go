class TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def index
    # @tweets = Tweet.page(params[:page]).reverse_order.order(created_at: :desc)
    @tweets = Tweet.all

  end

  def show
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    # @tweet.save
    # redirect_to tweets_path

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

end
