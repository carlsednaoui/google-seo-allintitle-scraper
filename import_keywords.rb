require 'csv'

CSV.open('keywords.csv', "r:ISO-8859-1").each do |row|
     Keyword.create(:word => row[0])
end
