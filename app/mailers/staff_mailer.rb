class StaffMailer < ApplicationMailer

  def welcome_email(staff, user_code, password)
    @staff = staff
    @user_code = user_code
    @password = password

    mail to: staff.details_info.email, subject: "Mail Chào Mừng Nhân Viên Mới"
  end


end
