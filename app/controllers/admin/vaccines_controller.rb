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

  private

  def vaccine_params
    params.require(:vaccine).permit(:code, :name, :manufacture, :content, :expiry_date, :inventory)
  end

  def set_vaccine
    @vaccine = Vaccine.find params[:id]
  end
end
