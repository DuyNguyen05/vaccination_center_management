class InfoAccountMailer < ApplicationMailer
  def send_email user
    @user = user
    mail to: @user.info_injection_book.email, subject: "Thông tin tài khoản đăng nhập"
  end
end
