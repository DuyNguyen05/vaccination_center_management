class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :user_code
      t.string :password
      t.references :role, foreign_key: true
      t.references :details_info, foreign_key: true

      t.timestamps
    end
  end
end
