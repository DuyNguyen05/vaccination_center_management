class Admin::AdminController < ApplicationController
  layout "admin/application"
  protect_from_forgery with: :exception

  before_action :authenticate_admin_admin!

end
