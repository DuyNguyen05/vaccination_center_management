class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private

  def default_url_options
    {locale: I18n.locale}
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user_account
      new_user_account_session_path
    elsif resource_or_scope == :admin
      new_admin_session_path
    else
      super
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if params[:user_account].present?
      user_root_path
    else
      super
    end
  end
end
