class CreateAppointment < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :book_code
      t.datetime :registration_date
      t.string :injection_type
      t.string :vaccine_id
      t.string :vaccination_center

      t.timestamps
    end
  end
end
