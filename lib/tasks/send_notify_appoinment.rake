namespace :send_notify_appointment do
  desc "Remove files student info after exporting to PDF"
  task send_notification_appoinment: :environment do
    NotifiSenderJob.perform_later
    # if Rails.env.development? || Rails.env.test?
    #   FileUtils.remove_dir("#{Rails.public_path}/exports/", true)
    # elsif Dir["#{ENV['ASSET_HOST_CARRIERWAVE']}#{ENV['EXPORT_FOLDER']}students_info/"].present?
    #   FileUtils.remove_dir("#{ENV['ASSET_HOST_CARRIERWAVE']}#{ENV['EXPORT_FOLDER']}students_info/", true)
    # end
  end

  # desc "Remove files teacher info after exporting to PDF"
  # task delete_teacher_document: :environment do
  #   if Rails.env.development? || Rails.env.test?
  #     FileUtils.remove_dir("#{Rails.public_path}/exports/", true)
  #   elsif Dir["#{ENV['ASSET_HOST_CARRIERWAVE']}#{ENV['EXPORT_FOLDER']}teachers_info/"].present?
  #     FileUtils.remove_dir("#{ENV['ASSET_HOST_CARRIERWAVE']}#{ENV['EXPORT_FOLDER']}teachers_info/", true)
  #   end
  # end
end
