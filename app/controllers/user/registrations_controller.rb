class User::RegistrationsController < Devise::RegistrationsController
	layout false

	def edit
	end

	def update
    @account = current_user_account
    password = account_params[:password]
    password_confirmation = account_params[:password_confirmation]
    if password == password_confirmation
      if @account.update(account_params)
        # Sign in the user by passing validation in case their password changed
        bypass_sign_in(@account)
        @account.update sign_in_count: 2
        redirect_to user_root_path
      else
        render "edit"
      end
    else
      flash[:alert] = "Mật khẩu không khớp. Vui lòng nhập chính xác."
      render "edit"
    end
	end

	private

  def account_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user_account).permit :password, :password_confirmation
  end
end