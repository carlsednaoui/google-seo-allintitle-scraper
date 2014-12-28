class Keyword < ActiveRecord::Base
  # attr_accessible :allintitle, :word
  
  validates :word, uniqueness: true
  
  def self.add_keywords(keywords)
    keywords.split("\r\n").each {|k| Keyword.create(word: k) unless Keyword.where(word: row[0]).count > 0}
  end
  
  def self.get_allintitle
    
    require 'nokogiri'
    require 'open-uri'
    
    base_url = "http://www.google.com/search?q=allintitle:"
    quotes = "%22"
    
    keywords = Keyword.where("allintitle IS NULL")
    
    keywords.each do |k|
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
  
end
