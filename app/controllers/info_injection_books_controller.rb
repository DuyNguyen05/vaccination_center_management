class InfoInjectionBooksController < ApplicationController
  before_action :find_injection_book, only: :create

  def new
    @info_injection_book = InfoInjectionBook.new
    @injection_book = @info_injection_book.injection_books.build
    @appointment = Appointment.new
    # respond_to do |format|
    #   format.js
    # end
  end

  def create
    respond_to do |format|
      if @injection_book.present?
        registration_date =  info_injection_book_params[:injection_books_attributes]["0"][:appointments_attributes]["0"][:registration_date]
        vaccine_id = info_injection_book_params[:injection_books_attributes]["0"][:appointments_attributes]["0"][:vaccine_id]
        @appointment = Appointment.new registration_date: registration_date, vaccine_id: vaccine_id, book_code: @injection_book.book_code
        @appointment.save
        format.js
      else
        @info_injection_book = InfoInjectionBook.new info_injection_book_params
        @info_injection_book.save
        format.js
      end
    end
  end

  private

  def info_injection_book_params
    params.require(:info_injection_book).permit :father_name, :identify_father, :email,
      :mother_name, :identify_mother, :number_phone, :guardian_name, :identify_guardian, :check_info,
      injection_books_attributes: [:id, :name_person_injected, :date_of_birth, :place_of_birth, :gender, :_destroy,
        appointments_attributes: [:id, :book_code, :registration_date, :vaccine_id, :injection_type, :vaccination_center]],
      addresses_attributes: [:id, :province, :district, :ward, :hometown, :current_address, :permanent_address]
  end

  def find_injection_book
    book_code = info_injection_book_params[:injection_books_attributes]["0"][:appointments_attributes]["0"][:book_code]
    @injection_book = InjectionBook.find_by(book_code: book_code) unless book_code.nil?
  end
end
