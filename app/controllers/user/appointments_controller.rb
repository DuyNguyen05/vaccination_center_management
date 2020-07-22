class User::AppointmentsController < User::UserController
  def index
    @appointments = Appointment.all.page(params[:page])
  end
end
