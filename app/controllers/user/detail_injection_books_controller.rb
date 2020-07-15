class User::DetailInjectionBooksController < User::UserController
  before_action :load_injection_book, only: [:create, :index]
  before_action :load_detail_injection_book, only: [:edit, :update, :show]
  before_action -> { authorize [:user, DetailInjectionBook] }

  def create
    if @injection_book.detail_injection_books.blank? || @injection_book.detail_injection_books.last.current_step == "step_5" || @injection_book.detail_injection_books.last.current_step == "waiting" || @injection_book.detail_injection_books.last.current_step == "cancel"
      @detail_injection_book = @injection_book.detail_injection_books.create! status: "waiting", injection_date: Time.now
      redirect_to user_detail_injection_book_path(@detail_injection_book)
    else
      flash[:notice] = "Đang trong tiến trình tiên. Tiếp tục hòan thành các bước tiêm."
      @detail_injection_book = @injection_book.detail_injection_books.last
      redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
    end
  end

  def edit
    @detail_bill = @detail_injection_book.bill.detail_bills if @detail_injection_book.current_step == "step_4"
    @check_before_injection = @detail_injection_book.build_check_before_injection if @detail_injection_book.check_before_injection.blank?
    @bill = @detail_injection_book.build_bill if @detail_injection_book.bill.blank?
    # @detail_bill = @bill.detail_bills.build if @bill.detail_bills.blank?
  end

  def index
  end

  def update
    response = InjectionService.new(detail_injection_book_params: detail_injection_book_params, detail_injection_book_id: params[:id], save_draft: params[:save_draft]).update_info_injection
    if response[1]
      flash[:notice] = response[0] unless response[0].blank?
    elsif !response[0].blank?
      flash[:alert] = response[0] unless response[0].blank?
    end
    @detail_injection_book.reload
    redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
  end

  private

  def load_injection_book
    @injection_book = InjectionBook.find(params[:injection_book])
  end

  def load_detail_injection_book
    @detail_injection_book = DetailInjectionBook.find(params[:id])
  end

  def detail_injection_book_params
    params.require(:detail_injection_book).permit :vaccination_center_id, :account_id,
      :react_after_injection, :status, :injection_date, :time_after_injection,
      check_before_injection_attributes: [:id, :conclude, :vaccine_type_id, :status,  answer_question: []],
      bill_attributes: [:id, :creation_time, :payment_time, :account_id, :injection_book_id, :total_money, :code,
        detail_bills_attributes: [:id, :vaccine_id, :vaccine_package_type_id, :number_injection, :next_appointment, :doctor_injected, :nurse_injected, :unit_price, :discount, :amount,
          :register_injection_package_id, :_destroy]]
  end
end
