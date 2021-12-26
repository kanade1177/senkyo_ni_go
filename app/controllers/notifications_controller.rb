class NotificationsController < ApplicationController
  def index
    #通知一覧
    @notifications = current_user.passive_notifications
    #通知を確認したら、既読状態にアップデート（false→）
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
