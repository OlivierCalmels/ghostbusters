class CreateFirstTableRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :first_table_records do |t|
      t.integer :emis_number
      t.string :teacher_surname
      t.string :teacher_name
      t.string :teacher_sex
      t.date :dob

      t.timestamps
    end
  end
end
