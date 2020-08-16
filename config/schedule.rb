job_type :rake,    "cd :path && :environment_variable=development bundle exec rake :task --silent :output"
set :output, error: "log/cron_error_log.log", standard: "log/cron_log.log"

every 1.minute do
  # runner "NotifiSenderJob.perform"
  rake "send_notify_appointment:send_notification_appoinment"
end