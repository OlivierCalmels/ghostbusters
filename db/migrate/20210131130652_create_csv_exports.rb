class CreateCsvExports < ActiveRecord::Migration[6.1]
  def change
    create_table :csv_exports do |t|

      t.timestamps
    end
  end
end
