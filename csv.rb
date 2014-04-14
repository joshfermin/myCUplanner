require 'csv'

include CsvMapper

schedules_csv = File.open('Test.csv')

# schedules = CSV.parse(schedules_csv, :headers => true)

# schedules.each do |row|
# 	Classes.add!(row.to_hash)
# end


# CSV.foreach(schedules_csv, :headers => true) do |row|
#   Course.create!(row.to_hash)
# end