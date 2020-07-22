class User::BillsController < User::UserController
  def index
    @bills = Bill.all.page(params[:page])
  end
end
