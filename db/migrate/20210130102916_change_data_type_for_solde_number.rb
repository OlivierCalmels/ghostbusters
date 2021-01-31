class ChangeDataTypeForSoldeNumber < ActiveRecord::Migration[6.1]
  ## Second table records
  # Matricule
  def self.up
    change_table :second_table_records do |t|
      t.change :solde_number, :string
    end
  end

  def self.down
    change_table :second_table_records do |t|
      t.change :solde_number, :integer
    end
  end

end
