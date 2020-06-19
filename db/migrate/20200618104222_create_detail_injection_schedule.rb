class CreateDetailInjectionSchedule < ActiveRecord::Migration[5.2]
  def change
    create_table :detail_injection_schedules do |t|
      t.references :vaccine, foreign_key: true
      t.integer :number_injection
      t.string :type_age
      t.string :age
      t.references :injection_schedule, foreign_key: true

      t.timestamps
    end
  end
end
