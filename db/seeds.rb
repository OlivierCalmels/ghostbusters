# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
JunctionRecord.destroy_all
FirstTableRecord.destroy_all
SecondTableRecord.destroy_all

FirstTableRecord.create!(emis_number: 1, teacher_surname: "2Nrydoss", teacher_name: "Guvyugu", teacher_sex: "Female", dob: "16/01/1978")
FirstTableRecord.create!(emis_number: 2, teacher_surname: "Adakma - Bahy", teacher_name: "Itku W", teacher_sex: "Female", dob: "12/04/1988")
FirstTableRecord.create!(emis_number: 3, teacher_surname: "Adakma-Gdumm", teacher_name: "Axydi", teacher_sex: "Female", dob: "29/12/1989")
FirstTableRecord.create!(emis_number: 4, teacher_surname: "Adoyhhi", teacher_name: "Gaziz", teacher_sex: "Male", dob: "29/07/1964")
FirstTableRecord.create!(emis_number: 5, teacher_surname: "Adoyhhi", teacher_name: "Gaziz", teacher_sex: "Male", dob: "06/10/1984")
FirstTableRecord.create!(emis_number: 6, teacher_surname: "Connor", teacher_name: "Mustache", teacher_sex: "Male", dob: "06/10/1984")

p "created #{FirstTableRecord.count} first table records"

SecondTableRecord.create!(solde_number: 1, name: "Urkiz", surname: "A’Koyh", dob: "15/02/1961")
SecondTableRecord.create!(solde_number: 2, name: "Axydi Ixyfupinl", surname: "Adakma-Gdumm", dob: "29/12/1989")
SecondTableRecord.create!(solde_number: 3, name: "Wvykqiz Uereznu", surname: "Adoyhhi", dob: "15/11/1961")
SecondTableRecord.create!(solde_number: 4, name: "Oagpu", surname: "Aeykxyka", dob: "24/04/1967")
SecondTableRecord.create!(solde_number: 5, name: "Utiaxu", surname: "Afykn-Punak", dob: "24/04/1999")
SecondTableRecord.create!(solde_number: 6, name: "Mustache", surname: "Connor", dob: "06/10/1984")

p "created #{SecondTableRecord.count} second table records"
