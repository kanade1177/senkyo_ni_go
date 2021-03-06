class CommentsController < ApplicationController
  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.build(comment_params)
    #コメントしたユーザーのIDとログインしているユーザーのIDの照合
    @comment.user_id = current_user.id
    #コメントされたツイートのIDとログインユーザーのID照合
    @comment.tweet_id = @tweet.id
    if @comment.save
      @tweet = @comment.tweet # 通知機能
      @tweet.create_notification_by(current_user) #ログインしているユーザーによる通知の作成
    end
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    @comment = @tweet.comments.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :tweet_id, :user_id)
  end
end
