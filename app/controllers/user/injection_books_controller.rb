class User::InjectionBooksController < User::UserController
  before_action :load_injection_book, only: :show
  before_action -> { authorize [:user, InjectionBook] }, only: [:new, :create, :show, :index]

  def index
    if current_user_account.is_user?
      @injection_books = current_user_account.info_injection_book.injection_books.newest.page(params[:page])
    else
      @injection_books = InjectionBook.newest.filter_injection_books(params[:query]).page(params[:page])
    end
  end

  def new
    @injection_book = InjectionBook.new
  end

  def create
    @injection_book = current_user_account.info_injection_book.injection_books.build injection_book_params
    if @injection_book.save
      redirect_to user_injection_books_path
    else
      render :new
    end
  end

  def show
  end

  private

  def injection_book_params
    params.require(:injection_book).permit :name_person_injected, :date_of_birth,
      :place_of_birth, :gender
  end

  def load_injection_book
    @injection_book = InjectionBook.find params[:id]
  end
end
