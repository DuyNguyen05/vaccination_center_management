class Admin::NotificationsController < Admin::AdminController

  def index
    if params[:unread].present?
      @notifications = Notification.unread.page(params[:page])
    else
      @notifications = Notification.all.page(params[:page])
    end
  end

end
