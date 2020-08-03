class User::AppointmentsController < User::UserController
	before_action :load_appointment, only: :destroy

  def index
    @appointments = Appointment.newest.filter_appointments(params[:query]).page(params[:page])
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
end
