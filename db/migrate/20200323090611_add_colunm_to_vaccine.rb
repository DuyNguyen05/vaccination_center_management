class AddColunmToVaccine < ActiveRecord::Migration[5.2]
  def change
    add_column :vaccines, :tag, :string, default: "default"
  end
end
