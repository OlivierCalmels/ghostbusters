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
    # on créé les associations autour des colonnes comparables pour chaque liste : {[X, Y, Z] => [Object1, Object2...]}
    t1_grouped = get_t1_associations(FirstTableRecord.all)
    t2_grouped = get_t2_associations(SecondTableRecord.all)
    
    # on sélectionne dans la T2 uniquement les "keys" qui n'ont qu'un seul objet en "value" (qui n'ont dont pas de doublon dans T2)
    t2_grouped_solo = t2_grouped.select {|key, value| value.count == 1}
    # Ici on créé une copie de t1_grouped et t2_grouped qui nous servira par la suite à conserver une version raccourcie des tables après premier traitement
    t1_grouped_others = get_t1_associations(FirstTableRecord.all)
    t2_grouped_others = get_t2_associations(SecondTableRecord.all)
    # si le traitement est lancé pour la première fois, on associe les clés 1:1 dans des JunctionRecord
    first_part_start = Time.now
    if JunctionRecord.count == 0
      # pour chaque groupe de t1, on cherche si il y a une key identique dans t2_grouped_solo ([X, Y, Z] == [X, Y, Z])
      t1_grouped.each do |key, value|
        if t2_grouped_solo.include?(key)
          # Si oui, on créé un JunctionRecord avec ces deux éléments (on pourrait ne pas calculer les scores et le fixer par défault)
          create_junction(value.first, t2_grouped_solo[key].first)
          # On prend les éléments de T1 qui ont été associés et on les retire de la liste initiale
          t1_grouped_others.delete(key)
          # Idem T2
          t2_grouped_others.delete(key)
        end
      end
    end
    first_part_end = Time.now

    p "#{JunctionRecord.count} ont été créées"
    p "Initialement, il y avait #{t1_grouped.count} dans T1"
    p "Il reste #{t1_grouped_others.count} dans le T1"
    p "Initialement, il y avait #{t2_grouped.count} dans T2"
    p "Il reste #{t2_grouped_others.count} groupes dans le T2"
    p "Le traitement a duré #{first_part_end - first_part_start} secondes"
    redirect_to filter_path
  end

  def filter #(score_limit)
    @junctions = JunctionRecord.where("score >= ?", 1)
    @alter_junction = []
    @junctions.each do |junction|
      appearances_first_table_id = @junctions.where("first_table_record_id = ?", junction.first_table_record_id)
      appearances_second_table_id = @junctions.where("second_table_record_id = ?", junction.second_table_record_id)
      if appearances_first_table_id.count == 1 && appearances_second_table_id.count == 1
        @alter_junction << junction
      end
    end
    export_filter
    @alter_junction
  end

  private

  def export_filter
    data = [["Numéro EMIS", "teacher_surname", "teacher_name","teacher_sex","Date of birth", "Numéro Solde","Surname","First name","Date of birth"]]
    
    @alter_junction.each do |junction|
      emis = junction.first_table_record
      payroll = junction.second_table_record
      data << [emis.emis_number, emis.teacher_surname, emis.teacher_name, emis.teacher_sex, emis.dob, payroll.solde_number, payroll.surname, payroll.name, payroll.dob]
    end
    p data
    CsvExport.export({data:data})
  end

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
