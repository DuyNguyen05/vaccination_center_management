class Admin::AccountsController < Admin::AdminController
  before_action :set_account, except: [:index, :new, :create]

  def index
    @accounts = Account.match_query(params[:query]).page(params[:page])
  end

  def new
    @account = Account.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @account = Account.new account_params
    respond_to do |format|
      if @account.save
        @accounts = Account.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @account.update Account_params
        @accounts = Account.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @account.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def account_params
    params.require(:account).permit(:company_code, :name, :address)
  end

  def set_account
    @account = account.find params[:id]
  end
end
