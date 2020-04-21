module Admin::SessionsHelper
  def log_in(admin)
    session[:admin_id] = admin.id
  end

  def logged_in?
    current_admin.present?
  end

  def log_out
    session.delete(:admin_id)
  end

  private

  def admin_check_login
    redirect_to admin_login_path unless logged_in?
  end
end
