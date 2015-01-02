# Google allintitle scraper

## About this app

If you're into SEO you probably know how valuable the "allintitle" data from Google is. If you have no idea of what I'm talking about, nevermind... none of this will really make sense.

For the SEO lovers, this is a simple scraper that lets you use Nokogiri to extract the "all in title" results from Google. This scraper is built using Ruby on Rails.

You simply add keywords (individually or in bulk) and then run the scraper rake task to query Google for your result counts. The scraper now incudes a history of result counts (the TitleResult object, belongs to Keyword) that allows tracking of changes over time.

## For users of the previous version:

Run '$ rake db:migrate' and then '$ rake scraper:update_keywords' to take existing keywords and create associate TitleResult objects in the DB. _Please back up your database before running this if you have info you don't want to lose!_

## Updates

* Added the TitleResult model to encapsulate result counts.
* Removed extraneous routes/methods from routes.rb - you can no longer edit/update keywords, only create and delete
* Altered keywords#index view to show previous/current counts with change (color coded)
* Updated keyword model to move scraping methods into a more logical structure, as well as several helpers
* Updated keywords#show to list out scrapes with a table showing change

## Getting your scraper ready:

1. Download a local copy of this app
2. Run '$ bundle'
3. Run '$ rake db:migrate'
4. Boot up the app either '$ rails server' and navigate to http://localhost:3000/
5. Make individual new keywords or add them via the 'add multiple keywords' option (line separated)
6. Run '$ rake scraper:get_all'
7. Profit!

You can view the results in your browser and also can click the excel output method to get all the results in an easily pastable format.

## Notes:

* Google typically limit 100 queries per day per IP address. (Time to visit your local coffee shops?)
* You cannot scrape more than once every 24 hours. This is a limit set in the model which you can individually override (keyword.getallintitle(true) to override). This is in place so that your history doesn't get all hosed as you go.

## Todo:

* Add charts
* Move to Bootstrap
* Add user auth for production use
* Set up for quick deploy to Heroku
* Create worker/cron process for automatic scraping
