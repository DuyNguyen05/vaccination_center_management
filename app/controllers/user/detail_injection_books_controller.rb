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
    if @detail_injection_book.valid?
      if params[:back_button].present?
        # @detail_injection_book.previous_step
        redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: DetailInjectionBook::STEPS[DetailInjectionBook::STEPS.index(params[:detail_injection_book][:steps]) - 1])
      elsif params[:save_draft].present?
        @detail_injection_book.update status: "cancel"
        # detail_injection_book_params[:check_before_injection_attributes].merge(answer_question: ["", "", "", "", "", "", "", ""]) if detail_injection_book_params[:check_before_injection_attributes].present? && detail_injection_book_params[:check_before_injection_attributes][:answer_question].blank?
        # @detail_injection_book.update_attributes! detail_injection_book_params
        # flash[:notice] = "Saved!"
        redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
      elsif @detail_injection_book.first_step?
        @detail_injection_book.next_step
        redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
      elsif @detail_injection_book.second_step?
        if params[:detail_injection_book][:check_before_injection_attributes][:answer_question].present? && (params[:detail_injection_book][:check_before_injection_attributes][:answer_question].length == 8) && params[:detail_injection_book][:check_before_injection_attributes][:status].present?
          if (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][1] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][2] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][3] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][4] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][5] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][6] == "true")
            flash[:alert] = "Tạm hoãn tiêm chủng (Khi CÓ điểm bất thường tại các mục 2,3,4,5,6,7)"
            params[:detail_injection_book][:check_before_injection_attributes][:status] = "disagree"
            @detail_injection_book.update_attributes detail_injection_book_params
            @detail_injection_book.update_attributes status: "cancel"
          elsif (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][0] == "true") || (params[:detail_injection_book][:check_before_injection_attributes][:answer_question][7] == "true")
            flash[:alert] = "Chống chỉ định tiêm chủng (Khi CÓ điểm bất thường tại các mục 1-8)"
            @detail_injection_book.update_attributes detail_injection_book_params
            @detail_injection_book.next_step
          elsif params[:detail_injection_book][:check_before_injection_attributes][:status] == "disagree"
            @detail_injection_book.update_attributes detail_injection_book_params
            @detail_injection_book.update_attributes status: "cancel"
          else
            @detail_injection_book.update_attributes detail_injection_book_params
            @detail_injection_book.next_step
          end
          redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
        else
          flash[:alert] = "Vui lòng nhập đủ thông tin để tiếp tục."
          redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
        end
      elsif @detail_injection_book.third_step?
        if params[:detail_injection_book][:bill_attributes][:detail_bills_attributes].present?
          @detail_injection_book.update! detail_injection_book_params
          @detail_injection_book.next_step
          redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
        else
          flash[:alert] = "Vui lòng nhập đủ thông tin để tiếp tục."
          redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
        end
      else
        @detail_injection_book.update detail_injection_book_params
        @detail_injection_book.next_step
        redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
      end
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
      :react_after_injection, :status, :injection_date, :time_after_injection,
      check_before_injection_attributes: [:id, :conclude, :vaccine_type_id, :status,  answer_question: []],
      bill_attributes: [:id, :creation_time, :payment_time, :account_id, :injection_book_id, :total_money, :code,
        detail_bills_attributes: [:id, :vaccine_id, :vaccine_package_type_id, :number_injection, :unit_price, :discount, :amount,
          :register_injection_package_id, :_destroy]]
  end
end
