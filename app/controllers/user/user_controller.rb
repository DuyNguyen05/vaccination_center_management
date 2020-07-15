class User::UserController < ApplicationController
  layout "user/application"

  include ApplicationHelper
  include Pundit
  protect_from_forgery with: :exception

  before_action :authenticate_user_account!
  alias_method :current_user, :current_user_account

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound do
    redirect_back fallback_location: user_root_path, alert: t("errors.messages.resource_not_found")
  end
  rescue_from ActiveRecord::RecordInvalid do
    redirect_back fallback_location: user_root_path, alert: t("errors.messages.record_invalid")
  end
  rescue_from ActionController::InvalidAuthenticityToken do
    redirect_back fallback_location: user_root_path, alert: t("errors.messages.invalid_authenticity_token")
  end

  private

  def user_not_authorized
    respond_to do |format|
      format.js { render "shared/user_not_authorized" }
      format.html do
        flash[:alert] = t "errors.user_not_authorized"
        redirect_to request.referrer || user_root_path
      end
    end
  end
end
