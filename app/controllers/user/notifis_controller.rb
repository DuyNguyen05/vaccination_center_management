class User::NotifisController < User::UserController
  def index
    @notifications = Notifi.where(account: current_user_account).unviewed.leatest

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @notification = Notifi.find(params[:id])

    message = @notification.update(notification_params) ? "Viewed notification" : "There was an error"

    redirect_to :back, notice: message
  end

  private
  def notification_params
    params.require(:notifi).permit(:opened_at)
  end
end