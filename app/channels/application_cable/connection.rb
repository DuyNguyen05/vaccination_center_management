module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user_account

    def connect
      self.current_user_account = find_verified_user
      logger.add_tags 'ActionCable', current_user_account.user_code
    end

    private

    def find_verified_user
      verified_user = env['warden'].user
      verified_user || reject_unauthorized_connection
    end
  end
end
