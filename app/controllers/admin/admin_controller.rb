class Admin::AdminController < ActionController::Base
  include Admin::SessionsHelper

  layout "admin/application"

  before_action :set_locale
  # before_action :admin_check_login

  protect_from_forgery with: :exception
  helper_method :current_admin

  def current_admin
    @current_admin ||= Account.find_by(id: session[:admin_id])
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def default_url_options
    {locale: I18n.locale}
  end
end
