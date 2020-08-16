class CreateNotifis < ActiveRecord::Migration[5.2]
  def change
    create_table :notifis do |t|
      t.references :account, foreign_key: true
      t.references :vaccine, foreign_key: true
      t.references :injection_book, foreign_key: true
      t.datetime :opened_at

      t.timestamps
    end
  end
end
