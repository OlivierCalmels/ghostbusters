class SecondTableRecord < ApplicationRecord
  has_many :junction_record

  def self.import(file)
    file ? filepath = file.path : filepath="data/Payroll_crop.csv"
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
