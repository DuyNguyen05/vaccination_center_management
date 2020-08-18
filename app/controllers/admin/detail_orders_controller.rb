class Admin::DetailOrdersController < Admin::AdminController

  def index
    @order = Order.find(params[:order_id])
    @detail_orders = @order.detail_orders.page(params[:page])
  end

  def new
    @company = Company.find(params[:company_id])
    @vaccines = Vaccine.where(company_code: @company.company_code).pluck(:name, :id)
    @order = @company.orders.new
  end

  def create
    @company = Company.find(params[:company_id])
    @order = @company.orders.new order_params
    if @order.save
      flash[:success] = t(".created")
      redirect_to admin_company_path(@company)
    else
      render :new
    end
  end

  def edit
    # @vaccines = Vaccine.pluck(:code, :id)
    @detail_order = DetailOrder.find(params[:id])
    @company = @detail_order.order.company
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      @detail_order = DetailOrder.find(params[:id])
      if @detail_order.update detail_order_params
        @order = Order.find(params[:order_id])
        @detail_orders = @order.detail_orders.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      @detail_order.destroy
      format.js
    end
  end

  private

  def detail_order_params
    params.require(:detail_order).permit(:account_id, :company_id, :vaccine_id, :quantity)
  end

  def set_company
    @company = Company.find(params[:company_id])
  end
end
