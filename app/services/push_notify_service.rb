class PushNotifyService
  attr_accessor :notify

  def initialize(notify)
    @notify = notify
  end

  def execute
    ActionCable.server.broadcast "notifications_channel",
    notification: ApplicationController.renderer.render(partial: "admin/notifications/notification", locals: { notification: @notify }), counter: ApplicationController.renderer.render(partial: "admin/notifications/counter", locals: { counter: Notification.unread.size })
  end
end
