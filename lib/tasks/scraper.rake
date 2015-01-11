namespace :scraper do
  desc "Get allintitle for ALL keywords"
  task :get_all => :environment do
    Keyword.get_allintitle
  end
end
