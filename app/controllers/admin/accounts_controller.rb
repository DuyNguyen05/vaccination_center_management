class Admin::AccountsController < Admin::AdminController
  before_action :set_account, except: [:index, :new, :create]

  def index
    @accounts = Account.includes(:details_info).filter_users(params[:query]).page(params[:page])
  end

  def show
  end

  def edit; end

  def update
    role = Role.find(params[:role_id])
    admin = Admin.find_by(user_code: @account.user_code)
    if @account.update role: role
      admin.update role: role if admin.present?
      flash[:success] = t(".updated")
    else
      render :edit
    end
  end

  def destroy
    @account.details_info.destroy
    flash[:success] = t(".deleted")
    redirect_to admin_accounts_path
  end

  private

  def account_params
    params.require(:account).permit(:role)
  end

  def set_account
    @account = Account.find params[:id]
  end
end
