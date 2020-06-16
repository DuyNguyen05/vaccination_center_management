class Admin::DetailVaccinePackagesController < Admin::AdminController
  before_action :set_vaccine_package_type, only: [:index, :new, :create]
  before_action :set_detail_vaccince_package, only: [:edit, :update, :destroy]

  def index
    @detail_vaccine_packages = @vaccine_package_type.detail_vaccine_packages
      .filter_vaccine(params[:query])
      .includes(:vaccine).page(params[:page])
  end

  def new; end

  def create
    response = ImportDetailVaccinePackageService.perform params[:file], current_admin_admin.user_code, @vaccine_package_type.id
    if response
      flash[:success] = t(".file_imported")
      redirect_to admin_vaccine_package_type_detail_vaccine_packages_path(@vaccine_package_type.id)
    else
      flash[:error] = t(".error_import")
      render :new
    end
  end

  def edit
    @vaccines = Vaccine.pluck(:code, :id)
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @detail_vaccine_package.update detail_vaccine_package_params
        vaccine_package_type = VaccinePackageType.find(@detail_vaccine_package.vaccine_package_type_id)
        @detail_vaccine_packages = vaccine_package_type.detail_vaccine_packages.includes(:vaccine).page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      @detail_vaccine_package.destroy
      format.js
    end
  end

  private

  def detail_vaccine_package_params
    params.require(:detail_vaccine_package).permit(:vaccine_id, :total_injections)
  end

  def set_vaccine_package_type
    @vaccine_package_type = VaccinePackageType.find(params[:vaccine_package_type_id])
  end

  def set_detail_vaccince_package
    @detail_vaccine_package = DetailVaccinePackage.find params[:id]
  end
end
