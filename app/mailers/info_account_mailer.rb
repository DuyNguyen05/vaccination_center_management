class InfoAccountMailer < ApplicationMailer
  def send_email user
    @user = user
    mail to: @user.info_injection_book.email, subject: "Information Account Email"
  end
end
