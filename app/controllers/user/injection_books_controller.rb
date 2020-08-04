class User::InjectionBooksController < User::UserController
  before_action :load_injection_book, only: [:show, :update]
  before_action -> { authorize [:user, InjectionBook] }, only: [:new, :create, :show, :index]

  def index
    if current_user_account.is_user?
      @injection_books = current_user_account.info_injection_book.injection_books.newest.filter_injection_books(params[:query]).page(params[:page])
    else
      @injection_books = InjectionBook.newest.filter_injection_books(params[:query]).page(params[:page])
      respond_to do |format|
        format.html
        format.json { render json: { injection_books: @injection_books.as_json(only: [:name_person_injected, :id]) } }
      end
    end
  end

  def new
    @injection_book = InjectionBook.new
  end

  def create
    @injection_book = current_user_account.info_injection_book.injection_books.build injection_book_params
    if @injection_book.save
      flash[:notice] = t("created")
      redirect_to user_injection_books_path
    else
      render :new
    end
  end

  def update
    @injection_book.update injection_book_params
    # respond_to do |format|
    #   # format.html { render(:text => "not implemented") }
    #   format.js
    # end
    # Cloudinary::Uploader.upload(injection_book_params[:image_attributes][:image_link])
    redirect_to user_injection_book_path(@injection_book)
  end

  def show
  end

  private

  def injection_book_params
    params.require(:injection_book).permit :name_person_injected, :date_of_birth,
      :place_of_birth, :gender, image_attributes: [:id, :image_link, :imageable_id, :imageable_type, :_destroy]
  end

  def load_injection_book
    @injection_book = InjectionBook.find params[:id]
  end
end
