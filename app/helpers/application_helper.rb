module ApplicationHelper
  require 'date'

  def active_class(link_path)
    current_page?(link_path) ? "sidebar-item selected" : "sidebar-item"
  end

  def age(dob)
    now = Time.now.utc.to_date
    age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    return t(".childbirth") if age == 0
    return t(".born_yet") if age < 0
    return age.to_s + t(".year_old") if age > 0
  end

  def vaccines
    @vaccines = Vaccine.newest.limit(8)
  end

  def vaccine_packages
    @vaccine_packages = VaccinePackageType.newest.limit(8)
  end

  def ajax_redirect_to(redirect_uri)
    { js: "window.location.replace('#{redirect_uri}');" }
  end

end
