class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :event
      t.datetime :opened_at
      t.integer :vaccine_id
      t.integer :admin_id

      t.timestamps
    end
  end
end
