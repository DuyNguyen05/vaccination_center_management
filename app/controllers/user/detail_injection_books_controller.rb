class User::DetailInjectionBooksController < User::UserController
  before_action :load_injection_book, only: :create
  before_action :load_detail_injection_book, only: [:edit, :update, :show]
  before_action -> { authorize [:user, DetailInjectionBook] }

  def create
    if @injection_book.detail_injection_books.blank? || @injection_book.detail_injection_books.last.current_step == "step_5"
      @detail_injection_book = @injection_book.detail_injection_books.create! status: "step_1", injection_date: Time.now
    else
      @detail_injection_book = @injection_book.detail_injection_books.last
    end
    redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
  end

  def edit
    @detail_bill = @detail_injection_book.bill.detail_bills if @detail_injection_book.current_step == "step_4"
  end

  def show
  end

  def update
    if @detail_injection_book.valid?
      if params[:back_button].present?
        @detail_injection_book.previous_step
      elsif params[:save_draft].present?
        @detail_injection_book.update! detail_injection_book_params
        flash[:notice] = "Saved!"
        # redirect_to @detail_injection_book
      elsif @detail_injection_book.first_step?
        if params[:detail_injection_book][:check_before_injection_attributes].present? && params[:detail_injection_book][:check_before_injection_attributes][:status].present? && (params[:detail_injection_book][:check_before_injection_attributes][:answer_question].length == 8)
          if (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][1] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][2] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][3] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][4] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][5] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][6] == "true")
            flash[:alert] = "Tạm hoãn tiêm chủng (Khi CÓ điểm bất thường tại các mục 2,3,4,5,6,7)"
          elsif (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][0] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][7] == "true")
            flash[:alert] = "Chống chỉ định tiêm chủng (Khi CÓ điểm bất thường tại các mục 1-8)"
            @detail_injection_book.update! detail_injection_book_params
            @detail_injection_book.next_step
          else
            @detail_injection_book.update! detail_injection_book_params
            @detail_injection_book.next_step
          end
        else
          flash[:alert] = "Vui lòng nhập đủ thông tin để tiếp tục."
        end
      else
        @detail_injection_book.update_attributes! detail_injection_book_params
        @detail_injection_book.next_step
      end
      redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
    end
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
      :react_after_injection, :status, :injection_date,
      check_before_injection_attributes: [:id, :conclude, :vaccine_type_id, :status,  answer_question: []],
      bill_attributes: [:id, :creation_time, :payment_time, :account_id, :injection_book_id, :total_money, :code,
        detail_bills_attributes: [:id, :vaccine_id, :vaccine_package_type_id, :number_injection, :unit_price, :discount, :amount,
          :register_injection_package_id]]
  end
end
