require "csv"
require "roo"

class ImportVaccinesService

  PARAMS_VACCINE = ["code", "name", "manufacture", "content", "expiry_date", "quantity", "price", "tag", "company_code"].freeze
  class << self
    def perform(file, user)
      data = open_file file
      header = data.row(1)
      (2..data.last_row).each do |i|
        params_vaccine = []
        (1..PARAMS_VACCINE.count).each do |ib|
          params_vaccine = params_vaccine << data.cell(i,ib)
        end
        row = [PARAMS_VACCINE, params_vaccine].transpose.to_h
        vaccine = Vaccine.create! row.merge(user_code: user)
        number_injection = 0
        (10..data.last_column).each do |number|
          number_injection = number_injection + 1
          vaccine.number_injections.create! name: "Mũi #{number_injection}", age: data.cell(i,number) unless data.cell(i,number).blank?
        end
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
