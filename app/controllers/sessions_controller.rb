class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    #入力したメールを持つユーザーの存在の確認及びパスワードの可否。あればtrueになる。
    if user && user.authenticate(params[:session][:password])
      #ユーザーを登録したと同時にログイン
      log_in user
      redirect_to user
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end
