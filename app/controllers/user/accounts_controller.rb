class User::AccountsController < User::UserController
  before_action :authenticate_user_account!
  before_action :load_account, only: [:show]
  before_action -> { authorize [:user, Account] }, only: [:edit, :index]

  def index
  end

  def show
  end

  # def edit
    
  # end

  # def update
  #   @account = current_user_account
  #   if @account.update(account_params)
  #     # Sign in the user by passing validation in case their password changed
  #     bypass_sign_in(@account)
  #     destroy_user_account_session_path
  #     redirect_to user_root_path
  #   else
  #     render "edit"
  #   end
  # end

  private

  def load_account
    @account = Account.find params[:id]
  end

  # def account_params
  #   # NOTE: Using `strong_parameters` gem
  #   params.require(:account).permit :password, :password_confirmation
  # end
end
