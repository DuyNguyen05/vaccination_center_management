
class Admin::HomeController < Admin::AdminController

  def index
    respond_to do |format|
      if params[:type] == "month"
        @vaccines = Vaccine.group_by_month(:created_at, format: "%b-%x", last: 6, current: true).count
        @detail_bills = DetailBill.group_by_month(:created_at, format: "%b-%x", last: 6, current: true).count
        @injection_books = InjectionBook.group_by_month(:created_at, format: "%b-%x", last: 6, current: true).count
      elsif params[:type] == "week"
        @vaccines = Vaccine.group_by_week(:created_at, last: 4, current: true).count
        @detail_bills = DetailBill.group_by_week(:created_at, last: 4, current: true).count
        @injection_books = InjectionBook.group_by_week(:created_at, last: 4, current: true).count
      elsif params[:type] == "year"
        @vaccines = Vaccine.group_by_year(:created_at, last: 3, current: true).count
        @detail_bills = DetailBill.group_by_year(:created_at, last: 3, current: true).count
        @injection_books = InjectionBook.group_by_year(:created_at, last: 3, current: true).count
      else
        @vaccines = Vaccine.group_by_day(:created_at, last: 7, current: true).count
        @injection_books = InjectionBook.group_by_day(:created_at, last: 7, current: true).count
        @detail_bills = DetailBill.group_by_day(:created_at, last: 7, current: true).count
        # @detail_bills = Bill.includes(:detail_bills, :vaccines).map{ |a| [a.created_at, a.vaccines.sum(:price)] }

      end
      format.js
      format.html
      format.json do
        render json: @vaccines.to_json
        render json: @detail_bills.to_json
        render json: @injection_books.to_json
      end
    end
  end
end
