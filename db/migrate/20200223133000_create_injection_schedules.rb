class CreateInjectionSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :injection_schedules do |t|
      t.references :vaccination_center, foreign_key: true
      t.datetime :injection_date
      t.datetime :registration_date
      t.references :vaccine_package, foreign_key: true
      t.string :book_code

      t.timestamps
    end
  end
end
