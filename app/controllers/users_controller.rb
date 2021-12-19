class UsersController < ApplicationController

  before_action :correct_user, only: [:edit]

  def new
    @user = User.new
  end

  def index
    @users = User.page(params[:page]).per(20)
    @tweet = Tweet.new
  end

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page]).per(6).order(created_at: :desc)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :image)
  end

  def correct_user
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user)
    end
  end

end