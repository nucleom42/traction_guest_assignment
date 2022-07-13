# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
id = Gov.find_or_create_by(gov_id_type: 'ID', description: 'Id')
ssn = Gov.find_or_create_by(gov_id_type: 'SSN', description: 'Social Security Number')
dl = Gov.find_or_create_by(gov_id_type: 'DL', description: "Driver's License")

5.times do |i|
  User.find_or_create_by(first_name: "name_#{i}_id", last_name: "last_name_#{i}_id", email: "test_id_#{i}@test.com",
                         gov: id, gov_id_number: "#{i}235-id-#{i}")
  User.find_or_create_by(first_name: "name_#{i}_ssn", last_name: "last_name_#{i}_ssn", email: "test_ssn_#{i}@test.com",
                         gov: ssn, gov_id_number: "#{i}235-ssn-#{i}")
  User.find_or_create_by(first_name: "name_#{i}_dl", last_name: "last_name_#{i}_dl", email: "test_dl_#{i}@test.com",
                         gov: dl, gov_id_number: "#{i}235-dl-#{i}")
end
