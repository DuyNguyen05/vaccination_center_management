class Admin::DepartmentsController < Admin::AdminController
  before_action :set_department, except: [:index, :new, :create]

  def index
    @departments = Department.page(params[:page])
  end

  def new
    @department = Department.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @department = Department.new department_params
    respond_to do |format|
      if @department.save
        @departments = Department.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @department.update department_params
        @departments = Department.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def show; end

  def destroy
    @department.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def department_params
    params.require(:department).permit(:name, :detail)
  end

  def set_department
    @department = Department.find params[:id]
  end
end
