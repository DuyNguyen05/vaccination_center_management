class CreateCheckBeforeInjections < ActiveRecord::Migration[5.2]
  def change
    create_table :check_before_injections do |t|
      t.string :answer_question
      t.string :conclude
      t.references :vaccine_type, foreign_key: true
      t.references :template, foreign_key: true

      t.timestamps
    end
  end
end
