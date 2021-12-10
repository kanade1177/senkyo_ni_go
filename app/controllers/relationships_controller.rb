class RelationshipsController < ApplicationController
  def create
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
  end
  
  def destroy
    Relationship.find_by(params[:user_id]).destroy
    redirect_to request.referer
  end

  def followings
    #フォロー
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(20)
  end

  def followers
    #フォロワー
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(20)
  end
end
