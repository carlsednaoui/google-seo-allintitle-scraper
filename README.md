# Google allintitle scraper

If you're into SEO you probably know how valuable the "allintitle" data from Google is. If you have no idea of what I'm talking about, nevermind... none of this will really make sense.

For the SEO lovers, this is a simple scraper that lets you use Nokogiri to extract the "all in title" results from Google. This scraper is built using Ruby on Rails.


## Getting your scraper ready:

1. Download a local copy of this app
2. Run $ bundle
3. Run $ rake db:migrate
4. Add the keywords you want to get the "allintitle" in column "A" of the keywords.csv file.
5. Run $ rails runner import_keywords.rb
6. Run $ rails runner scraper.rb

To view the results simply run your rails server and go to http://localhost:3000/.

If you want to import all this data back into Excel, this is the easiest way to do it:

1. Go to http://localhost:3000/
2. Hit Cmd + a
3. Hit Cmd + c
4. Go to Excel and "Paste Special" as unicode text
5. Voila!

## Notes:
Google typically limit 100 queries per day per IP address. (Time to visit your local coffee shops?)
