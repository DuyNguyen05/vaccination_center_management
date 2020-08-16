module User::VaccineHelper
  def list_vaccine
    Vaccine.default.newest.page(params[:page])
  end

  def list_vaccine_other
    Vaccine.other.newest.page(params[:page])
  end

  def age_for_vaccine age
  	now = Time.now.utc.to_date
    return t("vaccine.born_yet") if age < 1
    return t("vaccine.age_month", age: age) if age < 48
    if age > 48
    	year = age/12
    	month = age%12
	    return t("vaccine.age", year: year, month: month) 
	  end
  end
end
