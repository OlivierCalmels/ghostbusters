class AddColumnToSecondTableRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :second_table_records, :done, :boolean
  end
end
