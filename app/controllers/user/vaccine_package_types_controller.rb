class User::VaccinePackageTypesController < User::UserController
  def index
    if params[:id_injection_book].present?
      injection_book = InjectionBook.find(params[:id_injection_book])
      @vaccine_package_types = injection_book.vaccine_package_types.search_vaccines_packages(params[:vaccine_package_name]).newest
    else
      @vaccine_package_types = VaccinePackageType.search_vaccines_packages(params[:vaccine_package_name]).newest
    end
    respond_to do |format|
      format.html
      format.json { render json: { vaccine_package_types: @vaccine_package_types.as_json(only: [:name, :id]) } }
    end
  end
end
