env :PATH, ENV['PATH']
set :output, error: "log/cron_error_log.log", standard: "log/cron_log.log"

every 1.minute do
  runner "CheckQuantityVaccineJob.perform_now"
end

every 10.minutes do
  rake "list_tasks:auto_destroy"
end
