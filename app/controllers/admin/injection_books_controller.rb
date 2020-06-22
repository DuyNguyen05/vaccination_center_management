class Admin::InjectionBooksController < Admin::AdminController
  before_action :set_info_injection_book, except: [:update, :show]
  before_action :set_injection_book, only: [:show, :edit, :update, :destroy]

  def index
    @info_injection_book = InfoInjectionBook.find(params[:info_injection_book_id])
    @injection_books = @info_injection_book.injection_books.filter_injection_books(params[:query]).page(params[:page])
  end

  def show; end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @injection_book.update injection_book_params
        @info_injection_book = InfoInjectionBook.find(params[:injection_book][:info_injection_book_id])
        @injection_books = @info_injection_book.injection_books.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @injection_book.destroy
        @injection_books = @info_injection_book.injection_books.page(params[:page])
        format.js
      else
        format.js
      end
    end
  end

  private

  def injection_book_params
    params.require(:injection_book).permit(:name_person_injected, :date_of_birth, :place_of_birth, :gender)
  end

  def set_injection_book
    @injection_book = InjectionBook.find(params[:id])
  end

  def set_info_injection_book
    @info_injection_book = InfoInjectionBook.find(params[:info_injection_book_id])
  end
end
