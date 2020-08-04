class User::InjectionSchedulesController < User::UserController
  before_action :load_injection_schedule, only: [:edit, :update, :destroy]
  before_action -> { authorize [:user, InjectionSchedule] }

  def new
    @injection_schedule = InjectionSchedule.new
  end

  def create
    @injection_schedule = InjectionSchedule.new injection_schedule_params
    if @injection_schedule.save
      flash[:notice] = "Tạo thàng công!"
      redirect_to user_injection_schedule_path(@injection_schedule)
    else
      render "new"
    end
  end

  def update

  end

  def edit

  end

  def destroy

  end

  def schedule

  end

  private

  def load_injection_schedule
    @injection_schedule = InjectionSchedule.find(params[:id]) if params[:id]
  end

  def injection_schedule_params
    params.require(:injection_schedule).permit :injection_date, :registration_date,
      :injection_schedule_type, detail_injection_schedules_attributes: [:id, :vaccine_id, :number_injection, :age, :_destroy]
  end
end
