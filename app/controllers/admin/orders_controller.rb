class Admin::OrdersController < Admin::AdminController

  def index
    @company = Company.find(params[:company_id])
    @orders = @company.orders.page(params[:page])
  end

  def new
    @company = Company.find(params[:company_id])
    @vaccines = Vaccine.where(company_code: @company.company_code).pluck(:name, :id)
    @order = @company.orders.new
  end

  def create
    @company = Company.find(params[:company_id])
    @order = @company.orders.new order_params
    byebug
    if @order.save
      flash[:success] = t(".created")
      redirect_to admin_company_path(@company)
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:account_id, :company_id, vaccine_id: [], quantity: [])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
