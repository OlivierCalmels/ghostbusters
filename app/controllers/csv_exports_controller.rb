class CsvExportsController < ApplicationController

  def export(attributes{})
    filename = attributes[:filename] || "export-#{Date.today}"
    file_directory = attributes[file_directory] || raise
    col_sep = attributes[col_sep] || ";"
    data = attributes[data] || [[header1, header2, header3]]

    csv_options = { col_sep: ';', force_quotes: true, quote_char: '"' }
    
  end
end
