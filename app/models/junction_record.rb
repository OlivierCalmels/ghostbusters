class JunctionRecord < ApplicationRecord
  belongs_to :first_table_record
  belongs_to :second_table_record
end
