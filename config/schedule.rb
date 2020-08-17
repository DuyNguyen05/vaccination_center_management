set :environment, ENV["RAILS_ENV"]
set :output, error: "../log/cron_error_log.log", standard: "../log/cron_log.log"

every 1.minutes do
  # runner "NotifiSenderJob.perform"
  rake "send_notify_appointment:send_notification_appoinment"
end
