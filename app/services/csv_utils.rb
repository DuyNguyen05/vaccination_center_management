class CsvUtils
  class << self
    def to_csv_row(record, column_definitions)
      column_definitions.map { |column| column[:value].call(record) }
    end

    def csv_header(column_definitions)
      column_definitions.map { |column| column[:header] }
    end

    def naming(name, timestamp, index = nil, extension = "csv")
      if index
        "#{name}-#{timestamp}-#{index}.#{extension}"
      else
        "#{name}-#{timestamp}.#{extension}"
      end
    end

    def to_zip_input(csvs, name, timestamp, count = true)
      csvs.map.with_index do |content, index|
        filename = naming(name, timestamp, count ? index + 1 : nil, "csv")
        { content: content, name: filename }
      end
    end
  end
end
