class Admin::UsersController < Admin::AdminController

  def index
    @users = InfoInjectionBook.includes(:account)
      .filter_info_injection_books(params[:query])
      .page(params[:page])
  end
end
