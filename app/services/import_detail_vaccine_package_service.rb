require "csv"
require "roo"

class ImportDetailVaccinePackageService
  class << self
    def perform(file, user, vaccine_package_type)
      data = open_file file
      header = data.row(1)
      (2..data.last_row).each do |i|
        row = [header, data.row(i)].transpose.to_h
        DetailVaccinePackage.create! row.merge(vaccine_package_type_id: vaccine_package_type, user_code: user)
      end

    rescue StandardError => e
      puts e.message
      puts e.backtrace
    end

    private

    def open_file(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path)
      when ".xls" then Roo::Excel.new(file.path)
      when ".xlsx" then Roo::Excelx.new(file.path)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end
  end
end
