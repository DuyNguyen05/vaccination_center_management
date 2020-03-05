class Admin::ImportVaccinesController < Admin::AdminController

  def new
    @import_vaccine = ImportVaccine.new
  end

  def create
    @import_vaccine = ImportVaccine.new import_params
    if @import_vaccine.save
      redirect_to admin_root_path
    end
  end


  private

  def import_params
    params.require(:import_vaccine).permit(:company_code, :quantity, :vaccine_id, :account_id)
  end

end
