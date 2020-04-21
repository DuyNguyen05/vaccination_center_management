class Admin::SessionsController < Admin::AdminController
  # skip_before_action :admin_check_login

  def new
    @account = Account.new
  end

  def create
    byebug
    account = Account.find_by(user_code: params[:session][:user_code])
    if account&.authenticate(params[:session][:password]) && account.is_admin?
      flash[:success] = t(".welcome")
      log_in(account)
      redirect_to admin_root_path
    else
      @account = Account.new(login_params)
      flash[:warning] = t(".invalid")
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = t(".bye")
    redirect_to admin_login_path
  end

  private

  def login_params
    params.require(:session).permit(:user_code, :password)
  end
end
