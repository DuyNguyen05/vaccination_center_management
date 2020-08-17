class NotifiSenderJob < ActiveJob::Base
   queue_as :default

  def perform # this method dispatch when job is called
  	# detail_injection_books = DetailInjectionBook.where("next_appointment < ?", Time.now)
    appointments = Appointment.where.not(book_code: nil).where("registration_date > ?", Time.now)
    ids = appointments.pluck(ids)
  	if ids.length
  		ids.each do |id|
        NotifiBroadcastJob.perform_later(id)
	  	end
		end
  end
end
