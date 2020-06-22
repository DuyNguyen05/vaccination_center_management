class Admin::BillsController < Admin::AdminController

  def index
    @bills = Bill.filter_bill(params[:query]).page(params[:page])
  end

end
