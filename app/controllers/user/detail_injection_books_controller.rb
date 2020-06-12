class User::DetailInjectionBooksController < User::UserController
  before_action :load_injection_book, only: :create
  before_action :load_detail_injection_book, only: [:edit, :update]
  before_action -> { authorize [:user, DetailInjectionBook] }
  # include Wicked::Wizard
  # steps :step_1, :step_2, :step_3, :step_4, :step_5

  def create
    byebug
    if @injection_book.detail_injection_books.blank? || @injection_book.detail_injection_books.last.current_step == "step_5"
      @detail_injection_book = @injection_book.detail_injection_books.create! status: "step_1", injection_date: Time.now
    else
      @detail_injection_book = @injection_book.detail_injection_books.last
    end
    redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
  end

  def edit
  end

  def update
    byebug
    if @detail_injection_book.valid?
      if params[:back_button]
        @detail_injection_book.previous_step
      elsif @detail_injection_book.last_step?
        flash[:notice] = "Saved!"
      else
        byebug
        @detail_injection_book.update_attributes! detail_injection_book_params
        @detail_injection_book.next_step
      end
      redirect_to edit_user_detail_injection_book_path(@detail_injection_book, steps: @detail_injection_book.current_step)
    end
    # session[:order_params].deep_merge!(params[:order]) if params[:order]
    # @detail_injection_book = Order.new(session[:order_params])
    # @detail_injection_book.current_step = session[:order_step]
    # if @detail_injection_book.valid?
    #   if params[:back_button]
    #     @order.previous_step
    #   elsif @order.last_step?
    #     @detail_injection_book.save if @detail_injection_book.all_valid?
    #   else
    #     @detail_injection_book.next_step
    #   end
    #   session[:order_step] = @detail_injection_book.current_step
    # end
    # if @detail_injection_book.new_record?
    #   render "new"
    # else
    #   session[:order_step] = session[:order_params] = nil
    #   flash[:notice] = "Order saved!"
    #   redirect_to @detail_injection_book
    # end
  end

  # def new
  #   @detail_injection_book = @injection_book.detail_injection_books.new
  # end

  # def create
  #   redirect_to
  # end

  # def update
  #   @detail_injection_book.status = step
  #   @detail_injection_book.update_attributes detail_injection_book_params context: step
  #   render_wizard @detail_injection_book
  # end

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
      check_before_injection_attributes: [:id, :conclude, :vaccine_type_id, answer_question: []],
      bill_attributes: [:id, :creation_time, :payment_time, :account_id, :injection_book_id, :total_money, :code]
  end
end
