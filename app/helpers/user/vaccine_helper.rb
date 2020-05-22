module User::VaccineHelper
  def list_vaccine
    Vaccine.default.page(params[:page])
  end

  def list_vaccine_other
    Vaccine.other.page(params[:page])
  end
end
