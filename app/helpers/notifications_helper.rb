module NotificationsHelper
  #まだ確認していない通知があるかどうかの確認
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

  def notification_form(notification)
    #訪れた人の通知を@visiterに格納
    @visiter = notification.visiter
    @comment = nil
    @visiter_comment = notification.comment_id
    #フォロー、DM（チャット）、いいね、コメントの通知内容切り分け
    case notification.action
    when "follow" then
      tag.a(notification.visiter.name, href: user_path(@visiter)) + "があなたをフォローしました"#tag.aでリンク化
    when "chat" then
      tag.a(notification.visiter.name, href: user_path(@visiter)) + "からあなたにメッセージがあります"
    when "favorite" then
      tag.a(notification.visiter.name, href: user_path(@visiter)) + "が" + tag.a("あなたの投稿", href: tweet_path(notification.tweet_id)) + "にいいねしました"
    when "comment" then
      @comment = Comment.find_by(id: @visiter_comment)&.content
      tag.a(@visiter.name, href: user_path(@visiter)) + "が" + tag.a("あなたの投稿", href: tweet_path(notification.tweet_id)) + "にコメントしました"
    end
  end
end
