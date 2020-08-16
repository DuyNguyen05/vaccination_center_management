class User::AppointmentsController < User::UserController
	before_action :load_appointment, only: :destroy

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new appointment_params
    respond_to do |format|
      if @appointment.save 
        format.js {render ajax_redirect_to(user_appointments_path) }
      else
        format.js
      end
    end
  end

  def index
    if current_user_account.is_user?
      injection_books = InjectionBook.where(id: current_user_account.info_injection_book.injection_books.ids).pluck(:book_code)
      @appointments = Appointment.where(book_code: injection_books).newest.filter_appointments(params[:query]).page(params[:page])
    else
      @appointments = Appointment.newest.filter_appointments(params[:query]).page(params[:page])
    end
  end

  def destroy
  	respond_to do |format|
    	@appointment.destroy
      format.js
    end
  end

  private
  def load_appointment
  	@appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit :book_code, :registration_date, :vaccine_id, :injection_type, :vaccination_center
  end
end
