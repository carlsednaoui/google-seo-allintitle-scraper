require 'nokogiri'
require 'open-uri'

puts "currently running " + $0
puts "there are no keywords with empty allintitle" if Keyword.where("allintitle IS NULL").count == 0

def get_allintitle
  base_url = "http://www.google.com/search?q=allintitle:"
  quotes = "%22"

  Keyword.where("allintitle IS NULL").each do |k|
    puts "********************"
    keyword = k.word
    puts "currently scraping: " + keyword
    
    # Replace spaces in keyword with proper URL encoding format
    keyword = keyword.gsub(" ", "%20")

    # Build the url to use for Nokogiri
    url = base_url + quotes + keyword + quotes
    doc = Nokogiri::HTML(open("#{url}"))

    # Strip the google results
    result = doc.css('#resultStats').text
    result = result.gsub("About ","")
    result = result.gsub(" results", "")
    result = result.gsub(",", "")

    puts "all in title: " + result.to_s
    
    # Set and save the result
    k.allintitle = result.to_i
    k.save!
    puts "********************"

    # Sleep for couple seconds to avoid getting kicked out by Google
    sleep_time = 13+Random.rand(17).seconds
    puts "Sleeping for " + sleep_time.to_s + " seconds"
    sleep sleep_time
  end
end

get_allintitle

# =============
# Notes: Earlier this had to be used to find allintitle instead of doc.css('#resultStats')
# result = doc.css('div').first(9).last.text
# result = result.gsub("Advanced searchAbout ","")
# =============
