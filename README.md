# Heyya, welcome to Noko.

This is a super simple app that lets you use Nokogiri to extract the "all in title" results from Google. This comes in super handy for SEO purposes.

## How to use Noko:
1. Research the keywords you want to get the "all in title" for
2. Add those keywords to "keywords.csv"
3. Run $rake db:migrate
4. Run $rails runner import_keywords.rb
5. Run $rails runner scraper.rb


