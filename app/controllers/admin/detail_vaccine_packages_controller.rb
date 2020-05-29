class Admin::DetailVaccinePackagesController < Admin::AdminController
  before_action :set_vaccine_package_type

  def index
    byebug
    @detail_vaccince_packages = @vaccine_package_type.detail_vaccine_packages.includes(:vaccine)
  end

  def new; end

  def create
    byebug
    # @vaccine_package_type = VaccinePackageType.find(params[:vaccine_package_type_id])
    response = ImportDetailVaccinePackageService.perform params[:file], current_admin_admin.user_code, @vaccine_package_type.id
    if response
      flash[:success] = t(".file_imported")
      redirect_to admin_vaccines_path
    else
      flash[:error] = t(".error_import")
      render :new
    end
  end

  private

  def set_vaccine_package_type
    @vaccine_package_type = VaccinePackageType.find(params[:vaccine_package_type_id])
  end
end
