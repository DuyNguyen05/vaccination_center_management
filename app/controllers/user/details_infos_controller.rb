class User::DetailsInfosController < User::UserController
  def new
    @details_info = DetailsInfo.new
  end

  def create
    @details_info = DetailsInfo.new details_info_params
    if @details_info.save
      redirect_to user_account_path(@details_info)
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
