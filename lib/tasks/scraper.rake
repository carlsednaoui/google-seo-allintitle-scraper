namespace :scraper do
  desc "Get allintitle for ALL keywords"
  task :get_all => :environment do
    Keyword.get_allintitle
  end
  
  desc "Import keywords from keywords.csv to Keywords table"
  task :import => :environment do
    require 'csv'

    CSV.open('keywords.csv', "r:ISO-8859-1").each do |row|
      Keyword.create(:word => row[0]) unless Keyword.where(word: row[0]).count > 0
    end
  end
  
  desc "Update existing keywords to use the TitleResult model"
  task :update_keywords => :environment do
    
    Keyword.all.each do |k|
      begin
        k.title_results.create({google_count: k.allintitle, created_at: k.updated_at})
        k.update_attributes({allintitle: nil})
      rescue Exception => e
        puts e.message
        puts e.backtrace
      end
    end
    
  end
end
