class ExportCsvService
  def initialize(objects, column_definitions)
    @objects = objects
    @column_definitions = column_definitions
  end

  def perform(batch_size = nil)
    require "csv"
    bom = "\uFEFF"
    CSV.generate(bom) do |csv|
      csv << csv_header
      if batch_size.present?
        objects.find_each(batch_size: batch_size) do |object|
          csv << to_csv_row(object)
        end
      else
        objects.each do |object|
          csv << to_csv_row(object)
        end
      end
    end
  end

  private

  def to_csv_row(record)
    CsvUtils.to_csv_row(record, column_definitions)
  end

  def csv_header
    CsvUtils.csv_header(column_definitions)
  end

  attr_reader :column_definitions, :objects
end
