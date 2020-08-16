class Notifi < ApplicationRecord
  belongs_to :account
  belongs_to :vaccine
  belongs_to :injection_book

  after_create { NotifiBroadcastJob.perform_later(self) }

  scope :leatest, ->{order("created_at DESC")}
  scope :unviewed, ->{where(opened_at: nil)}

  def self.for_user(account_id)
    Notifi.where(account_id: account_id).unviewed.count
  end
end
