class NotifyVaccineJob < ApplicationJob
  queue_as :default

  def perform(id)
    vaccine = Vaccine.find(id)
    notify = Notification.create(event: vaccine.name)
    PushNotifyService.new(notify).execute
  end
end
