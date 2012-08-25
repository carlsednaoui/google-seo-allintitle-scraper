require 'csv'
CSV.open('keywords.csv', 'r').each do |row|
     Keyword.create(:word => row[0])
end
