class CsvImportsController < ApplicationController
  require 'csv'

  def index
    @firsts = FirstTableRecord.all
    @seconds = SecondTableRecord.all
    redirect_to csv_imports_path
  end

  def create
    JunctionRecord.delete_all
    FirstTableRecord.delete_all
    SecondTableRecord.delete_all
    FirstTableRecord.import(params[:file1])
    SecondTableRecord.import(params[:file2])
    flash[:success] = "Tables 1 and 2 imported!"
    @firsts = FirstTableRecord.all
    @seconds = FirstTableRecord.all
    redirect_to new_csv_import_path
  end

end
