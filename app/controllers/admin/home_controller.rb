
class Admin::HomeController < Admin::AdminController

  def index
    # if params[:type] == "month"
    #   @data_product = Vaccine.all_data_product2
    #   @data_user = Account.all_data_user2
    #   @data_order = InjectionBook.all_data_order2
    # elsif params[:type] == "week"
    #   @data_product = Vaccine.all_data_product1
    #   @data_user = Account.all_data_user1
    #   @data_order = InjectionBook.all_data_order1
    # else
    #   @data_product = Vaccine.all_data_product
    #   @data_user = Account.all_data_user
    #   @data_order = InjectionBook.all_data_order
    # end
    # @data_user = Account.group_by_day(:created_at).count
    # byebug
  end
end
