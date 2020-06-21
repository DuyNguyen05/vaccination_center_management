
class Admin::HomeController < Admin::AdminController

  def index
    respond_to do |format|
      if params[:type] == "month"
        @account = Account.group_by_month(:created_at, format: "%b-%x").count
      elsif params[:type] == "week"
        @account = Account.group_by_week(:created_at).count
      else
        @account = Account.group_by_day(:created_at).count
      end
      format.js
      format.html
      format.json do
        render json: @account.to_json
      end
      byebug
    end
  end
end
