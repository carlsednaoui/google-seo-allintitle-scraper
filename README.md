# Google allintitle scraper

## Updated to make it more user-friendly (this is debatable :-P )

If you're into SEO you probably know how valuable the "allintitle" data from Google is. If you have no idea of what I'm talking about, nevermind... none of this will really make sense.

For the SEO lovers, this is a simple scraper that lets you use Nokogiri to extract the "all in title" results from Google. This scraper is built using Ruby on Rails.

## Getting your scraper ready:

1. Download a local copy of this app
2. Run $ bundle
3. Run $ rake db:migrate
4. Boot up the app either 'rails server' and navigate to http://localhost:3000/
5. Make individual new keywords or add them via the 'add multiple keywords' option (line separated)
6. Run 'rake scraper:get_all'
7. Profit!

You can view the results in your browser and also can click the excel output method to get all the results in an easily pastable format.

## Notes:

Google typically limit 100 queries per day per IP address. (Time to visit your local coffee shops?)
