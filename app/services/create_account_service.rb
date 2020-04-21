class CreateAccountService
  attr_accessor :params

  def initialize params
    @info_injection_book_id = params[:info_injection_book_id]
    @details_info_id = params[:details_info_id]
  end

  def create_account(admin = nil)
    if @info_injection_book_id.present?
      user_code = generate_user_code("PARENT-")
      Account.create! user_code: user_code, password: ENV["INIT_ACCOUNT_PASSWORD"],
        info_injection_book_id: @info_injection_book_id, role_id: Settings.active_record.account.role.user
    elsif admin == "true"
      user_code = generate_user_code("ADMIN-")
      Account.create! user_code: user_code, password: ENV["INIT_ACCOUNT_PASSWORD"],
        details_info_id: @details_info_id, role_id: Settings.active_record.account.role.admin
    else
      user_code = generate_user_code("STAFF-")
      byebug
      Account.create! user_code: user_code, password: ENV["INIT_ACCOUNT_PASSWORD"],
        details_info_id: @details_info_id, role_id: Settings.active_record.account.role.staff
    end
  end

  private

  def generate_user_code(code)
    source = (0..9).to_a
    user_code = code
    5.times{ user_code += source[rand(source.size)].to_s }
    account = Account.find_by user_code: user_code
    while account.present? do
      user_code = code
      5.times{ user_code += source[rand(source.size)].to_s }
      account = Account.find_by user_code: user_code
    end
    user_code
  end
end
