class FirstTableRecord < ApplicationRecord
  require 'csv'
  has_many :junction_record

  def self.import(file) # data/EMIS_crop.csv
    file ? filepath = file.path : filepath="data/EMIS_crop.csv"
    csv_option = { col_sep: ';', headers: true }
    CSV.foreach(filepath, csv_option) do |row|
      emis_number = row[0]
      teacher_surname = row[1]
      teacher_name = row[2]
      teacher_sex = row[3]
      dob = row[4]
      table_record = FirstTableRecord.create!(  emis_number: emis_number,
                                                teacher_surname: teacher_surname,
                                                teacher_name: teacher_name,
                                                teacher_sex: teacher_sex,
                                                dob: dob
                                              )
    end
  end
end
