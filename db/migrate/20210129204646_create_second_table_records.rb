class CreateSecondTableRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :second_table_records do |t|
      t.integer :solde_number
      t.string :surname
      t.string :name
      t.date :dob

      t.timestamps
    end
  end
end
