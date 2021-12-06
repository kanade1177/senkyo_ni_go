module SessionsHelper
  
  # def log_in(user)
  #   session[:user_id] = user.id
  # end  
  
  def log_in(user)
    session[:user_id] = user.id
  end
 
  # 現在ログインしているユーザーを返す (ユーザーがログイン中の場合のみ)
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
 
 
  def logged_in?
    !current_user.nil?
    # ログイン中の状態＝セッションにユーザーが存在する＝current_userがnilでない状態。
  end
 
  def log_out
    session.delete(:user_id)
    @current_user = nil　　　
  end
  
end
