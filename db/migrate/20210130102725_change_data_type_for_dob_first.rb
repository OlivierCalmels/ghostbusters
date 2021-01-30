class ChangeDataTypeForDobFirst < ActiveRecord::Migration[6.1]
  ## First table records
  # DOB
  def self.up
    change_table :first_table_records do |t|
      t.change :dob, :string
    end
  end

  def self.down
    change_table :first_table_records do |t|
      t.change :dob, :date
    end
  end
end
