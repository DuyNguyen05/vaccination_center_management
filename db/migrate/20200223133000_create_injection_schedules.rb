class CreateInjectionSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :injection_schedules do |t|
      t.datetime :injection_date
      t.datetime :registration_date
      t.string :injection_schedule_type

      t.timestamps
    end
  end
end
