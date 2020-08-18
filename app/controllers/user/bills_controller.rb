class User::BillsController < User::UserController
	before_action :load_bill, only: [:show, :update, :export_bill]
  before_action -> { authorize [:user, Bill] }, only: [:new, :show, :index, :update, :export_bill]

  def index
    @bills = Bill.all.filter_bills(params[:query]).page(params[:page]).newest
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

  def export_bill
    vaccination_center = VaccinationCenter.last
    options = {bill: @bill, vaccination_center: vaccination_center}
    @export = ::ExportBillService.new(options).create_document
    respond_to do |format|
      format.js
    end
  end

  private
  def load_bill
  	@bill = Bill.find(params[:id])
  end
end
