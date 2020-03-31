class Admin::DetailsInfosController < Admin::AdminController
  attr_accessor :role
  def new
    @details_info = DetailsInfo.new
  end

  def create
    @details_info = DetailsInfo.new details_info_params
    if @details_info.save
      role = params[:details_info][:admin]
      CreateAccountService.new(details_info_id: @details_info.id).create_account(role)
      redirect_to admin_root_path
    else
      render :new
    end
  end

  private

  def details_info_params
    params.require(:details_info).permit :first_name, :last_name,
      :email, :identify, :number_phone, :current_address, :permanent_address,
      :bank, :bank_account_number, :language, :certificate, :experience, :nationality,
      :gender, :tax_code, :vaccination_center_id, :department_id
  end
end
