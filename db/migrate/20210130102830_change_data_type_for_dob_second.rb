class ChangeDataTypeForDobSecond < ActiveRecord::Migration[6.1]
## Second table records
# DOB
  def self.up
    change_table :second_table_records do |t|
      t.change :dob, :string
    end
  end
  def self.down
    change_table :second_table_records do |t|
      t.change :dob, :date
    end
  end
end
