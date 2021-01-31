require 'csv'

class CsvImportsController < ApplicationController

  def csv_import
    FirstTableRecord.destroy_all
    SecondTableRecord.destroy_all
    import_first_csv
    import_second_csv
  end

  # 1 seul match => 100% (suprimer 1 instance dans la table 2 et remplir un autre CSV avec la correspondance)
  # Doublon ou + à 100 + > garde 1 seul (suppr les instances dans la T2 et remplur le CSV )
  # Douclon avec 2 options me^me score > on le met en bas de la pile

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
      done = row[4]

      table_record = SecondTableRecord.create!( solde_number: solde_number,
                                                surname: surname,
                                                name: name,
                                                dob: dob,
                                                done: done
                                              )
    end
  end
end
