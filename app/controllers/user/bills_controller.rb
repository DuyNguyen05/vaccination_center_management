class User::BillsController < User::UserController
	before_action :load_bill, only: [:show, :update]
  before_action -> { authorize [:user, Bill] }, only: [:new, :show, :index, :update]

  def index
    @bills = Bill.all.page(params[:page]).newest
  end

  def show
  	# @bill.update cashier_id: current_user_account.id, payment_time: Time.now
  	# @bill.detail_injection_book.next_step
  end

  def update
    respond_to do |format|
      if @bill.update cashier_id: current_user_account.id, payment_time: Time.now
        @bill.detail_injection_book.next_step
        format.js 
      else
        format.js 
      end
    end
  end

  private
  def load_bill
  	@bill = Bill.find(params[:id])  	
  end
end
