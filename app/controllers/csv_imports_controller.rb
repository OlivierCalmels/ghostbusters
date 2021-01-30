require 'csv'

class CsvImportsController < ApplicationController

  def csv_import
    FirstTableRecord.delete_all
    SecondTableRecord.delete_all
    import_first_csv
    import_second_csv
  end

  def import_first_csv(filepath = 'Namibia teachers data EMIS.csv')
    # filepath = 'Namibia teachers data EMIS.csv'
    csv_option = { col_sep: ',', headers: true }
    CSV.foreach(filepath, csv_option) do |row|
      emis_number = row[0]
      teacher_surname = row[1]
      teacher_name = row[2]
      teacher_sex = row[3]
      dob = row[4]
      # JJ/MM/AA en string
      # migrateion date => string
      # 15396 => 15/30/56
      # raise
      table_record = FirstTableRecord.create!(  emis_number: emis_number,
                                                teacher_surname: teacher_surname,
                                                teacher_name: teacher_name,
                                                teacher_sex: teacher_sex,
                                                dob: dob
                                              )
    end
  end

  def import_second_csv(filepath = 'Namibia teachers data Payroll.csv')
    # filepath = 'Namibia teachers data Payroll.csv'
    csv_option = { col_sep: ',', headers: true }
    CSV.foreach(filepath, csv_option) do |row|
      solde_number = row[0]
      surname = row[1]
      name = row[2]
      dob = row[3]

      table_record = SecondTableRecord.create!( solde_number: solde_number,
                                                surname: surname,
                                                name: name,
                                                dob: dob
                                              )
    end
  end
end