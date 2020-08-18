set :environment, "development"
set :output, error: "../log/cron_error_log.log", standard: "../log/cron_log.log"

every 1.minutes do
  # runner "NotifiSenderJob.perform_later"
  rake "send_notify_appointment:send_notification_appoinment"
end
