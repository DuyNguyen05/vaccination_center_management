class User::AccountsController < User::UserController
  before_action :load_account, only: [:show]
  before_action -> { authorize [:user, Account] }, only: [:edit]
  before_action -> { authorize [:user, Account] }, only: [:index]

  def index
  end

  def show
  end

  private

  def load_account
    @account = Account.find params[:id]
  end
end
