class AddColunmToCheckBeforeInjection < ActiveRecord::Migration[5.2]
  def change
    add_column :check_before_injections, :status, :string
  end
end
