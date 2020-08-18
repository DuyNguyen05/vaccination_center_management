class Admin::NotificationsController < Admin::AdminController

  def index
    if params[:unread].present?
      @notificationss = Notification.unread.order(id: :desc).page(params[:page])
    else
      @notificationss = Notification.order(id: :desc).page(params[:page])
    end
  end

  def update
    if params[:update_all].present?
      @notifications = Notification.unread
      if @notifications.update_all(opened_at: Time.zone.now)
        flash[:success] = "Cập Nhật Thành Công"
        redirect_to admin_notifications_path
      end
    end
  end

end
