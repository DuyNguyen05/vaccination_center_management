class User::InfoInjectionBooksController < User::UserController
  before_action :load_info_injection_book, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
    @info_injection_book = InfoInjectionBook.new
    @info_injection_book.injection_books.build
  end

  def create
    @info_injection_book = InfoInjectionBook.new info_injection_book_params
    if @info_injection_book.save
      redirect_to user_account_path(@info_injection_book.account.id)
    else
      render :new
    end
  end

  private

  def info_injection_book_params
    params.require(:info_injection_book).permit :father_name, :identify_father, :email,
      :mother_name, :identify_mother, :number_phone, :current_address, :permanent_address,
      injection_books_attributes: [:id, :name_person_injected, :date_of_birth,
        :place_of_birth, :gender]
  end

  def load_info_injection_book
    @info_injection_book = InfoInjectionBook.find params[:id]
  end
end
