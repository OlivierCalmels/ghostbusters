require 'string/similarity'

class JunctionRecordsController < ApplicationController

  def fusion
    first_table_records = FirstTableRecord.all
    second_table_records = SecondTableRecord.all

    first_table_records.each do |first_record|
      second_table_records.each do |second_record|
        create_junction(first_record, second_record)
      end
    end

    p JunctionRecord.all
    redirect_to identical_path
  end

  def identical
    p "valeur second table"
    p SecondTableRecord.count
    p" qqty groupe de données"
    grouped_data = get_t2_associations(SecondTableRecord.all)
    p grouped_data.count
    p "les valeurs uniques dans la table 2"
    # HASH qui contient des lignes : 
    #["Guvyugu", "2Nrydoss", Mon, 16 Jan 1978]=> [#<FirstTableRecord id: 217, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16">
    grouped_data = grouped_data.select {|key, value| value.count == 1}

    t1_grouped = get_t1_associations(FirstTableRecord.all)
    # t1_grouped.each do |key, value|
    #   if grouped_data.include?(key)
    #     create_junction(value.first, grouped_data[key].first)
    #   end
    # end
    p t1_grouped
    # croiser T1grouped et grouped_data pour sortir


  end

  private
  
  def create_junction(first_table_record, second_table_record)
    @junction_record = JunctionRecord.new(first_table_record: first_table_record, second_table_record: second_table_record)
    @junction_record.score = calculate_score_cosine(@junction_record)
    @junction_record.save
  end

  def calculate_score_cosine(junction_record)
    score = String::Similarity.cosine junction_record.first_table_record.teacher_name, junction_record.second_table_record.name
    return score
  end

  def calculate_score_levenshtein_distance(junction_record)
    score = String::Similarity.levenshtein_distance junction_record.first_table_record.teacher_name, junction_record.second_table_record.name
    return score
  end

  def get_t1_associations(array)
    # return 
    #"{["Guvyugu", "2Nrydoss", Mon, 16 Jan 1978]=>
    #    [#<FirstTableRecord id: 217, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16", created_at: "2021-01-30 11:02:00.699405000 +0000", updated_at: "2021-01-30 11:02:00.699405000 +0000">, 
         #<FirstTableRecord id: 222, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16", created_at: "2021-01-30 11:02:00.757533000 +0000", updated_at: "2021-01-30 11:02:00.757533000 +0000">, 
         #<FirstTableRecord id: 227, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16", created_at: "2021-01-30 11:02:00.814470000 +0000", updated_at: "2021-01-30 11:02:00.814470000 +0000">, 
         #<FirstTableRecord id: 232, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16", created_at: "2021-01-30 11:02:00.872564000 +0000", updated_at: "2021-01-30 11:02:00.872564000 +0000">, 
         #<FirstTableRecord id: 237, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16", created_at: "2021-01-30 11:02:00.937349000 +0000", updated_at: "2021-01-30 11:02:00.937349000 +0000">, 
         #<FirstTableRecord id: 242, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16", created_at: "2021-01-30 11:02:00.997268000 +0000", updated_at: "2021-01-30 11:02:00.997268000 +0000">, 
         #<FirstTableRecord id: 247, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16", created_at: "2021-01-30 11:02:01.054421000 +0000", updated_at: "2021-01-30 11:02:01.054421000 +0000">, 
         #<FirstTableRecord id: 252, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16", created_at: "2021-01-30 11:02:01.110988000 +0000", updated_at: "2021-01-30 11:02:01.110988000 +0000">, 
         #<FirstTableRecord id: 257, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16", created_at: "2021-01-30 11:02:01.169493000 +0000", updated_at: "2021-01-30 11:02:01.169493000 +0000">, 
         #<FirstTableRecord id: 262, emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "1978-01-16", created_at: "2021-01-30 11:02:01.226603000 +0000", updated_at: "2021-01-30 11:02:01.226603000 +0000">], 
    # ["Itku W", "Adakma-Gdumm", Tue, 12 Apr 1988]=>
    #   [#<FirstTableRecord id: 218, emis_number: 2, teacher_surname: "Adakma-Gdumm", teacher_name: "Itku W", teacher_sex: "Female", dob: "1988-04-12", created_at: "2021-01-30 11:02:00.705560000 +0000", updated_at: "2021-01-30 11:02:00.705560000 +0000">, 
         #<FirstTableRecord id: 223, emis_number: 2, teacher_surname: "Adakma-Gdumm", teacher_name: "Itku W", teacher_sex: "Female", dob: "1988-04-12", created_at: "2021-01-30 11:02:00.763209000 +0000", updated_at: "2021-01-30 11:02:00.763209000 +0000">, 
         #<FirstTableRecord id: 228, emis_number: 2, teacher_surname: "Adakma-Gdumm", teacher_name: "Itku W", teacher_sex: "Female", dob: "1988-04-1"]
    # }"
    array.group_by {|p| [p.teacher_name, p.teacher_surname, p.dob] }
  end

  def get_t2_associations(array)
    array.group_by {|p| [p.name, p.surname, p.dob] }
  end
end
