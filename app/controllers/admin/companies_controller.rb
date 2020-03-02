class Admin::CompaniesController < Admin::AdminController
  before_action :set_company, except: [:index, :new, :create]

  def index
    @companies = Company.match_query(params[:query]).page(params[:page])
  end

  def new
    @company = Company.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @company = Company.new company_params
    respond_to do |format|
      if @company.save
        @companies = Company.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @company.update company_params
        @companies = Company.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @company.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def company_params
    params.require(:company).permit(:company_code, :name, :address)
  end

  def set_company
    @company = Company.find params[:id]
  end
end
