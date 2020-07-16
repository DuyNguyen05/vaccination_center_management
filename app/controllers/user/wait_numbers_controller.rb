class User::WaitNumbersController < User::UserController
  before_action :load_account, only: [:new]
  def index

  end

  def new
    @wait_number = @account.doctor_rooms.build
    respond_to do |format|
      format.js
    end
  end

  def create
    account = Account.find_by(id: params[:wait_number][:account_id])
    @wait_number = account.doctor_rooms.build wait_number_params
    @wait_number.save
    respond_to do |format|
      format.js
    end
  end

  private

  def wait_number_params
    params.require(:wait_number).permit :nurse_id, :room, :injection_book_id, :appointment, :number, :detail_bill
  end

  def load_account
    @account = Account.find_by(id: params[:account_id])
  end
end
