class InjectionService
  attr_accessor :detail_injection_book_params, :detail_injection_book_id, :save_draft

  def initialize args
    @save_draft = args[:save_draft]
    @detail_injection_book_params = args[:detail_injection_book_params]
    @detail_injection_book = DetailInjectionBook.find(args[:detail_injection_book_id])
    @current_step = @detail_injection_book.current_step
  end

  def update_info_injection
    case @current_step
    when "step_1"
      if @save_draft.present?
        @detail_injection_book.update status: "cancel"
        return ["", true]
      end
      step_1
    when "step_2"
      step_2
    when "step_5"
      message = "Lỗi dữ liệu"
      return [message, false]
    else
      @detail_injection_book.update detail_injection_book_params
      @detail_injection_book.next_step
      return ["", true]
    end
  end

  private

  def step_1
    if @detail_injection_book_params[:check_before_injection_attributes][:answer_question].present? && (@detail_injection_book_params[:check_before_injection_attributes][:answer_question].length == 8) && @detail_injection_book_params[:check_before_injection_attributes][:status].present?
      if (@detail_injection_book_params[:check_before_injection_attributes][:answer_question][1] == "true") || (@detail_injection_book_params[:check_before_injection_attributes][:answer_question][2] == "true") || (@detail_injection_book_params[:check_before_injection_attributes][:answer_question][3] == "true") || (@detail_injection_book_params[:check_before_injection_attributes][:answer_question][4] == "true") || (@detail_injection_book_params[:check_before_injection_attributes][:answer_question][5] == "true") || (@detail_injection_book_params[:check_before_injection_attributes][:answer_question][6] == "true")
        message = "Tạm hoãn tiêm chủng (Khi CÓ điểm bất thường tại các mục 2,3,4,5,6,7)"
        @detail_injection_book_params[:check_before_injection_attributes][:status] = "disagree"
        @detail_injection_book.update_attributes @detail_injection_book_params
        @detail_injection_book.update_attributes status: "cancel"
        return [message, false]
      elsif (@detail_injection_book_params[:check_before_injection_attributes][:answer_question][0] == "true") || (@detail_injection_book_params[:check_before_injection_attributes][:answer_question][7] == "true")
        message = "Chống chỉ định tiêm chủng (Khi CÓ điểm bất thường tại các mục 1-8)"
        @detail_injection_book.update_attributes @detail_injection_book_params
        @detail_injection_book.next_step
        return [message, false]
      elsif @detail_injection_book_params[:check_before_injection_attributes][:status] == "disagree"
        @detail_injection_book.update_attributes @detail_injection_book_params
        @detail_injection_book.update_attributes status: "cancel"
        return ["", false]
      else
        @detail_injection_book.update_attributes @detail_injection_book_params
        @detail_injection_book.next_step
        return ["", true]
      end
    else
      message = "Vui lòng nhập đủ thông tin để tiếp tục."
      return [message, false]
    end
  end

  def step_2
    if @detail_injection_book_params[:bill_attributes][:detail_bills_attributes].present?
      @detail_injection_book.update_attributes @detail_injection_book_params
      @detail_injection_book.next_step
      return ["", true]
    else
      message = "Vui lòng nhập đủ thông tin để tiếp tục."
      return [message, false]
    end
  end
end
