class CsvExport < ApplicationRecord
  require 'csv'

  def self.export(attributes = {}) # filename, file_directory, data (array to export, first row as headers) col_sep (optional)
    # data_default = [ %w(header1 header2 header3), %w(r1c1 r1c2 r1c3), %w(r2c1 r2c2 r2c3), %w(r3c1 r3c2 r3c3)]
    filename = attributes[:filename]  || "Filtered_1:1_correlation.csv"
    file_directory = attributes[:file_directory]  || "public/"
    col_sep = attributes[:col_sep] || ";"
    data = attributes[:data] # || data_default

    filepath = "#{file_directory}/#{filename}"
    csv_options = { col_sep: col_sep, force_quotes: true, quote_char: '"', headers: true }

    CSV.open(filepath, 'wb', csv_options) do |csv|
      data.each do |row|
        csv << row #  %w(header1 header2 header3)
      end
    end
  end

end
