class CreateFormTemplate < ActiveRecord::Migration[5.2]
  def change
    create_table :form_templates do |t|
      t.string :content
    end
  end
end
