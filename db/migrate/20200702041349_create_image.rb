class CreateImage < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :image_link
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps
    end
  end
end
