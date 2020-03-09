class User::UserController < ApplicationController
  layout "user/application"

  include Pundit
  protect_from_forgery with: :exception

  before_action :authenticate_user_account!

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    respond_to do |format|
      format.js { render "shared/user_not_authorized" }
      format.html do
        flash[:danger] = t "errors.user_not_authorized"
        redirect_to request.referrer || current_user.root_path
      end
    end
  end
end
