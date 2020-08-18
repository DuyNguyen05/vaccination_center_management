class Admin::AdminController < ApplicationController
  layout "admin/application"
  protect_from_forgery with: :exception

  before_action :authenticate_admin_admin!
  before_action :set_notification


  def set_notification
    @notifications = Notification.unread.order("id DESC")
  end

end
