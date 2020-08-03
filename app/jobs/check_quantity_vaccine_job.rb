class CheckQuantityVaccineJob < ApplicationJob
  # queue_as :sidekiq

  def perform
    Rails.logger.info("JOB RUNNING")
    vaccines = Vaccine.where("quantity <= 20")
    ids = vaccines.pluck(:id)
    if ids.length
      ids.each do |id|
        NotifyVaccineJob.perform_later(id)
      end
    end
  end
end
