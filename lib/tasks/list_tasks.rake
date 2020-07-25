namespace :list_tasks do
  desc "Destroy after 1 month"
  task auto_destroy: :environment do
    Notification.destroy_all
  end
end
