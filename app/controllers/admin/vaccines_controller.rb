class Admin::VaccinesController < Admin::AdminController
  before_action :set_vaccine, only: [:edit, :update, :destroy]

  def index
    @vaccines = Vaccine.match_query(params[:query]).page(params[:page])
  end

  def new
    @vaccine = Vaccine.new
  end

  def create
    @vaccine = Vaccine.new(vaccine_params)
    if @vaccine.save
      redirect_to admin_vaccines_path
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @vaccine.update vaccine_params
        @vaccines = Vaccine.all
        format.js
      else
        render :edit
      end
    end
  end

  def destroy
    @vaccine.destroy
    @vaccines = Vaccine.all
    respond_to do |format|
      format.js
    end
  end

  def import
    response = ImportVaccinesService.perform params[:file], "1"
    if response
      flash[:success] = t(".file_imported")
      redirect_to admin_vaccines_path
    else
      flash[:error] = t(".error_import")
      redirect_to admin_vaccines_path
    end
  end

  private

  def vaccine_params
    params.require(:vaccine).permit(:code, :name, :manufacture, :content, :expiry_date, :inventory, :quantity, :account_id, :company_id)
  end

  def set_vaccine
    @vaccine = Vaccine.find params[:id]
  end
end
