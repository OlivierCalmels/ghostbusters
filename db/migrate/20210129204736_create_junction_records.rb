class CreateJunctionRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :junction_records do |t|
      t.references :first_table_record, null: false, foreign_key: true
      t.references :second_table_record, null: false, foreign_key: true
      t.float :score

      t.timestamps
    end
  end
end
