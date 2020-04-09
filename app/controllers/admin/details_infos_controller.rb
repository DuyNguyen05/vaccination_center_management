class Admin::DetailsInfosController < Admin::AdminController
  before_action :set_details_info, except: [:new, :create, :index]

  def new
    @details_info = DetailsInfo.new
  end

  def create
    @details_info = DetailsInfo.new details_info_params
    if @details_info.save
      redirect_to admin_root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @details_info.update details_info_params
      flash[:success] = t("updated")
      redirect_to admin_account_path(@details_info.account)
    else
      render :edit
    end
  end

  private

  def details_info_params
    params.require(:details_info).permit :first_name, :last_name,
      :email, :identify, :number_phone, :current_address, :permanent_address,
      :bank, :bank_account_number, :language, :certificate, :experience, :nationality,
      :gender, :tax_code, :vaccination_center_id, :department_id
  end

  def set_details_info
    @details_info = DetailsInfo.find(params[:id])
  end
end
