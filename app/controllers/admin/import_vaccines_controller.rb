class Admin::ImportVaccinesController < Admin::AdminController

  def new; end

  def create
    response = ImportVaccinesService.perform params[:file], current_admin_admin.user_code
    if response
      flash[:success] = t(".file_imported")
      redirect_to admin_vaccines_path
    else
      flash[:error] = t(".error_import")
      redirect_to admin_vaccines_path
    end
  end
end
