module SessionsHelper
  #セッションコントローラー渡されているユーザーでログイン
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    #ログイン中の場合、現在ログインしているユーザーを返す
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    #ユーザーがログインしていればtrue,していなければfalse
    !current_user.nil?
  end

  def log_out
    #現在のユーザーをログアウト。current_userがnilになれば
    session.delete(:user_id)
    @current_user = nil
  end
end
