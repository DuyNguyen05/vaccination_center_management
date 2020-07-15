module User::ApplicationHelper
  def check_online account
    return account.online? ? "primary" :  "secondary"
  end

  def check_button account
    return account.online? ? "visible" :  "invisible"
  end
end
