class Notification < ApplicationRecord
  belongs_to :vaccine, optional: true
  belongs_to :admin, optional: true

  scope :unread, -> { where opened_at: nil }

  # def perform
  #   ActionCable.server.broadcast "notifications_channel",
  #   notification: ApplicationController.renderer.render(partial: "admin/notifications/notification", locals: { notification: self }), counter: ApplicationController.renderer.render(partial: "admin/notifications/counter", locals: { counter: Notification.unread.size })
  # end
end
