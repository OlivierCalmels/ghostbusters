class ChangeDataTypeForEmisNumber < ActiveRecord::Migration[6.1]
  ## First table records
  # Matricule
  def self.up
    change_table :first_table_records do |t|
      t.change :emis_number, :string
    end
  end

  def self.down
    change_table :first_table_records do |t|
      t.change :emis_number, :integer
    end
  end
end
