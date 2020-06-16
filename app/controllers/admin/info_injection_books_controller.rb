class Admin::InfoInjectionBooksController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = InfoInjectionBook.includes(:account)
      .filter_info_injection_books(params[:query])
      .page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @user.update info_injection_book_params
      flash[:success] = t(".updated")
      redirect_to admin_info_injection_book_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def info_injection_book_params
    params.require(:info_injection_book).permit :father_name, :identify_father, :email,
      :mother_name, :identify_mother, :number_phone, :current_address, :permanent_address,
      injection_books_attributes: [:id, :name_person_injected, :date_of_birth,
        :place_of_birth, :gender]
  end

  def set_user
    @user = InfoInjectionBook.find(params[:id])
  end
end
