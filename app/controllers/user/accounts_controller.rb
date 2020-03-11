class User::AccountsController < User::UserController
  before_action :load_account, only: [:show]
  before_action -> { authorize [:user, @account] }, only: :edit

  def show
  end

  private

  def load_account
    @account = Account.find params[:id]
  end
end
