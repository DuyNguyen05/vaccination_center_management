require 'csv'

Province.transaction do
  ActiveRecord::Base.connection.execute("TRUNCATE table provinces")

  CSV.foreach(Rails.root.join('db', 'master_data', 'provinces.csv'), headers: true) do |row|
    attrs = row.to_h.symbolize_keys
    Province.create!(attrs)
  end
end

District.transaction do
  ActiveRecord::Base.connection.execute("TRUNCATE table districts")

  CSV.foreach(Rails.root.join('db', 'master_data', 'districts.csv'), headers: true) do |row|
    attrs = row.to_h.symbolize_keys
    District.create!(attrs)
  end
end
