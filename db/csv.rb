require 'csv'

# include CsvMapper

schedules_csv = File.open('Schedules.csv', :encoding => 'windows-1251:utf-8')

schedules = CSV.parse(schedules_csv, :headers => true)

schedules.each do |row|
	Course.add!(row.to_hash)
end


# CSV.foreach(schedules_csv, :headers => true) do |row|
#   Course.create!(row.to_hash)
# end