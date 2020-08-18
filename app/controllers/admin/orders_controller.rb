class Admin::OrdersController < Admin::AdminController
  before_action :set_company

  def index
    @orders = @company.orders.page(params[:page])
  end

  def new
    @vaccines = Vaccine.where(company_code: @company.company_code).pluck(:name, :id)
    @order = @company.orders.new
    @order.detail_orders.build
  end

  def create
    @order = @company.orders.new order_params
    byebug
    if @order.save
      flash[:success] = t(".created")
      redirect_to admin_company_orders_path(@company.id)
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      @order = Order.find(params[:id])
      @detail_orders = @order.detail_orders.page(params[:page])
      format.html
      format.csv do
        csv = ExportCsvService.new @detail_orders, DetailOrder.search_csv_column_definitions
        send_data csv.perform(1000), filename: "#{@order.code}.csv"
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    @orders = @company.orders.page(params[:page])
    respond_to do |format|
      format.js
    end

  end

  private

  def order_params
    params.require(:order).permit(:account_id, :company_id, :code, detail_orders_attributes: [:id, :vaccine_id, :quantity])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
