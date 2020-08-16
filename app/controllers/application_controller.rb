class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

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
    elsif resource_or_scope == :admin_admin
      new_admin_admin_session_path
    else
      super
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if params[:user_account].present?
      if current_user_account.sign_in_count == 1
        edit_user_account_registration_path
      else
        user_root_path
      end
    else
      admin_root_path
    end
  end

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end
end
