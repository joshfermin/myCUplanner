# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

# FasterCSV.foreach("RAILS.root/Schedules.csv") do |row|

CSV.foreach("Schedules.csv") do |row|
	Course.create(
	:subject_area => row[0],
	:course_number => row[1],
	:ext_number => row[2],
	:course_title => row[3],
	:instructor => row[4],
	:day => row[5],
	:start_time => row[6],
	:end_time => row[7],
	:building => row[8],
	:room => row[9],
	)
end