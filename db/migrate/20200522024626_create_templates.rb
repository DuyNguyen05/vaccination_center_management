class CreateTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :templates do |t|
      t.text :content, limit: 4294967295

      t.timestamps
    end
  end
end
