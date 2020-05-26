class Admin::VaccinePackageTypesController < Admin::AdminController
  before_action :set_vaccine_package_type, only: [:edit, :update, :destroy]

  def index
    @vaccine_package_types = VaccinePackageType.find_by_name(params[:query]).page(params[:page])
  end

  def new
    @vaccine_package_type = VaccinePackageType.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @vaccine_package_type = VaccinePackageType.new vaccine_package_type_params
    respond_to do |format|
      if @vaccine_package_type.save
        @vaccine_package_types = VaccinePackageType.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if@vaccine_package_type.update vaccine_package_type_params
        @vaccine_package_types = VaccinePackageType.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def destroy
   @vaccine_package_type.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def vaccine_package_type_params
    params.require(:vaccine_package_type).permit(:name)
  end

  def set_vaccine_package_type
    @vaccine_package_type = VaccinePackageType.find params[:id]
  end
end
