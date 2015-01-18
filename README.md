# Google allintitle scraper

## About this app

If you're into SEO you probably know how valuable the "allintitle" data from Google is. If you have no idea of what I'm talking about, nevermind... none of this will really make sense.

For the SEO lovers, this is a simple scraper that lets you use Nokogiri to extract the "all in title" results from Google. This scraper is built using Ruby on Rails.

You simply add keywords (individually or in bulk) and then run the scraper rake task to query Google for your result counts. The scraper now incudes a history of result counts (the TitleResult object, belongs to Keyword) that allows tracking of changes over time.

The tool keeps track of the changes as you go, and provides trendline data for keywords with over two scrapes. This can help identify terms that are becoming opportunities or are rapidly increasing in competitiveness. Ideally, you should be able to create and track a long list of terms over time to watch and anticipate competition around money terms.

At the current state of build, you should be able to run several thousand keywords through this without issue. Just need pagination/table-sort to make it easy to view!

## For users of the previous versions:

2014-12-29: Run '$ rake db:migrate' and then '$ rake db_update:update_keywords' to take existing keywords and create associate TitleResult objects in the DB. _Please back up your database before running this if you have info you don't want to lose!_

2015-01-11: Run '$ rake db:migrte' and then '$ rake db_update:add_counters' do add the counters to your keyword records.

## Updates

2014-12-29

* Added the TitleResult model to encapsulate result counts.
* Removed extraneous routes/methods from routes.rb - you can no longer edit/update keywords, only create and delete
* Altered keywords#index view to show previous/current counts with change (color coded)
* Updated keyword model to move scraping methods into a more logical structure, as well as several helpers
* Updated keywords#show to list out scrapes with a table showing change
* Updated to Bootstrap (via BootstrapCDN)
* Added charts with Highcharts (via highcharts-rails gem) and a regression model
* Overhauled the UX a whole bunch to color code and provide a better grasp of what is trending

2014-01-11

* Added favorites for Keywords using a quick ajax method
* Added ability to filter favorites & non in the index page
* Added basic counter stats for competition levels
* Added an r_value column for Keywords
* Various bug fixes

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

* Google typically limits you to 100 queries per day per IP address. Go patronize your local coffee shop or use a VPN!
* You cannot scrape more than once every 24 hours. This is a limit set in the model which you can individually override (keyword.getallintitle(true) to override). This is in place so that your history doesn't get all hosed as you go.
* Apparently sometimes the allintitle count is wildly out of whack for some terms. This mucks with trendlines, so I'm investigating an algorithm that will allow me to discard results that are statistical outliers (or at least severely discount them)

## Todo:

* Add pagination and sorted tables
* Add user auth for production use
* Set up for quick deploy to Heroku
* Create worker/cron process for automatic scraping
* Add Bing and other search engine scraping
