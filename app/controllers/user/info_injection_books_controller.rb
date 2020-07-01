class User::InfoInjectionBooksController < User::UserController
  before_action :load_info_injection_book, except: [:index, :new, :create]
  before_action -> { authorize [:user, InfoInjectionBook] }, only: [:index, :new, :create]

  def index
    @info_injection_books = InfoInjectionBook.includes(:account).newest.filter_info_injection_books(params[:query]).page(params[:page])
  end

  def show
  end

  def new
    @info_injection_book = InfoInjectionBook.new
    # @info_injection_book.injection_books.build
  end

  def create
    @info_injection_book = InfoInjectionBook.new info_injection_book_params
    if @info_injection_book.save
      redirect_to user_info_injection_books_path
    else
      render :new
    end
  end

  private

  def info_injection_book_params
    params.require(:info_injection_book).permit :father_name, :identify_father, :email,
      :mother_name, :identify_mother, :number_phone, :guardian_name, :identify_guardian,
      injection_books_attributes: [:id, :name_person_injected, :date_of_birth,
        :place_of_birth, :gender, :_destroy],
      addresses_attributes: [:id, :province, :district, :ward, :hometown, :current_address, :permanent_address]
  end

  def load_info_injection_book
    @info_injection_book = InfoInjectionBook.find params[:id]
  end
end
