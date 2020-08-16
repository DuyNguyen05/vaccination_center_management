class NotificationService
  attr_accessor :notification

  def initialize(notification)
    @notification = notification
  end

  def execute
    notification_count = Notifi.for_user(@notification.account_id)

    ActionCable.server.broadcast "notifis_channel", notification: ApplicationController.renderer.render(partial: "user/notifis/notifi", locals: { notification: @notification }), 
      counter: ApplicationController.renderer.render(partial: "user/notifis/counter", locals: { counter: notification_count) })
  end
end