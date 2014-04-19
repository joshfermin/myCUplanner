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
	:course_number => row[0],
	:course_title => row[1],
	:room => row[2],
	:instructor => row[3],
	:time => row[4],
	)
end