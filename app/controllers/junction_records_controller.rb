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
    @junction_records = JunctionRecord.where("score < ?", 5)
  end

  private
  
  def create_junction(first_table_record, second_table_record)
    @junction_record = JunctionRecord.new(first_table_record: first_table_record, second_table_record: second_table_record)
    @junction_record.score = calculate_score_levenshtein_distance(@junction_record)
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
