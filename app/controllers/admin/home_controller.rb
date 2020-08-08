
class Admin::HomeController < Admin::AdminController

  def index
    if params[:type] == "month"
      @vaccines = Vaccine.group_by_month(:created_at, format: "%b-%x", last: 6, current: true).count
      @detail_bills = Bill.group_by_month(:created_at, last: 6, current: true).sum(:total_money)
      @injection_books = InjectionBook.group_by_month(:created_at, format: "%b-%x", last: 6, current: true).count
    elsif params[:type] == "week"
      @vaccines = Vaccine.group_by_week(:created_at, last: 4, current: true).count
      @detail_bills = Bill.group_by_week(:created_at, last: 4, current: true).sum(:total_money)
      @injection_books = InjectionBook.group_by_week(:created_at, last: 4, current: true).count
    elsif params[:type] == "year"
      @vaccines = Vaccine.group_by_year(:created_at, last: 3, current: true).count
      @injection_books = InjectionBook.group_by_year(:created_at, last: 3, current: true).count
      @detail_bills = Bill.group_by_year(:created_at, last: 3, current: true).sum(:total_money)
    else
      @vaccines = Vaccine.group_by_day(:created_at, last: 7, current: true).count
      @injection_books = InjectionBook.group_by_day(:created_at, last: 7, current: true).count
      @detail_bills = Bill.group_by_day(:created_at, last: 7, current: true).sum(:total_money)
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
end
