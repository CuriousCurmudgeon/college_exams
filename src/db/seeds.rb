# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do |i|
    College.create()
end

colleges = College.all
exams = Exam.create([
    { college: colleges.first, start_time: DateTime.parse("2021-06-01"), end_time: DateTime.parse("2021-06-30") },
    { college: colleges.last, start_time: DateTime.parse("2021-07-01"), end_time: DateTime.parse("2021-07-31") }
])

User.create([
    { first_name: "Brittany", last_name: "Slayes", phone_number: "1234567890", exams: exams },
    { first_name: "Devin", last_name: "Townsend", phone_number: "0293840239" },
    { first_name: "Floor", last_name: "Jansen", phone_number: "0630812321" }
])