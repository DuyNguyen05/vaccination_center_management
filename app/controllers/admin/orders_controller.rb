class Admin::OrdersController < Admin::AdminController

  def index
    @company = Company.find(params[:company_id])
    @orders = @company.orders.page(params[:page])
  end

  def new
    @company = Company.find(params[:company_id])
    @vaccines = Vaccine.where(company_code: @company.company_code).pluck(:name, :id)
    @order = @company.orders.new
    @order.detail_orders.build
  end

  def create
    @company = Company.find(params[:company_id])
    @order = @company.orders.new order_params
    if @order.save
      flash[:success] = t(".created")
      redirect_to admin_company_orders_path(@company.id)
    else
      render :new
    end
  end

  def show
    respond_to do |format|
      format.html do
        @order = Order.find(params[:id])
        @detail_orders = @order.detail_orders.page(params[:page])
      end
      format.csv do
        csv = ExportCsvService.new @detail_orders, DetailOrder.search_csv_column_definitions
        send_data csv.perform(1000), filename: "order-#{Time.current.to_i}.csv"
      end
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
