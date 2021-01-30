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
    t1_grouped.each do |key, value|
      if grouped_data.include?(key)
        create_junction(value.first, grouped_data[key].first)
      end
    end

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
end
