class AddCompanyToImportVaccines < ActiveRecord::Migration[5.2]
  def change
    add_reference :import_vaccines, :company, foreign_key: true
  end
end
