class User::HomesController < User::UserController
	before_action :load_bills, only: :index

  def index
  end

  private
  def load_bills
  	@bills = Bill.where("payment_time is NULL").newest.page(params[:page]) if current_user_account.is_staff?
  end
end
