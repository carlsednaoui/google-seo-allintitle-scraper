class Keyword < ActiveRecord::Base
  
  validates :word, uniqueness: true
  # validates :favorite, presence: true
  
  has_many :title_results, dependent: :destroy
  
  @@base_url = "http://www.google.com/search?q=allintitle:"
  @@quotes = "%22"
  @@competition_levels = {
    none: 0,
    low: 1,
    mild: 2,
    medium: 3,
    high: 4
  }
  
  def self.base_url
    @@base_url
  end
  
  def self.quotes
    @@quotes
  end
  
  def self.competition_levels
    @@competition_levels
  end
  
  def self.add_keywords(keywords)
    keywords.split("\r\n").each {|k| Keyword.create(word: k) unless Keyword.where(word: row[0]).count > 0}
  end
  
  def self.get_allintitle
    self.all.each do |k|
      puts "********************"
      puts "currently scraping: " + k.word
      scraped = k.get_allintitle
      
      puts "********************"
      if scraped
        # Sleep for couple seconds to avoid getting kicked out by Google
        sleep_time = 13+Random.rand(17).seconds
        puts "Sleeping for " + sleep_time.to_s + " seconds"
        sleep sleep_time
      end
    end
  end
  
  def switch_favorite
    update_attributes({favorite: !favorite})
  end
  
  def get_allintitle(override=false)
    
    if !ready_to_scrape?
      puts "Skipping: Less than one day since last scrape!"
      return false
    end unless override
    
    require 'nokogiri'
    require 'open-uri'
    # Replace spaces in word with proper URL encoding format
    word = self.word.gsub(" ", "%20")

    # Build the url to use for Nokogiri
    url = @@base_url + @@quotes + word + @@quotes
    doc = Nokogiri::HTML(open("#{url}"))

    # Strip the google results
    result = doc.css('#resultStats').text
    result = result.gsub("About ","")
    result = result.gsub(" results", "")
    result = result.gsub(",", "")

    puts "all in title: " + result.to_s
    
    # Replaced with a new model for time-based analysis
    begin
      self.title_results.create({google_count: result.to_i})
      return true
    rescue Exception => e
      puts e.message
      puts e.backtrace
      puts 'Mountain View, we have a problem...'
      return false
    end
    
  end
  
  def allintitle
    title_results.order(created_at: :desc).first
  end
  
  def allintitle_list_with_date
    title_results.order(created_at: :asc).map {|tr| ["Date.UTC(#{tr.created_at.year},#{tr.created_at.month - 1},#{tr.created_at.day})",tr.google_count] }
  end
  
  def allintitle_list
    title_results.order(created_at: :asc).map {|tr| tr.google_count }
  end
  
  def current_allintitle
    title_results.order(created_at: :desc).first
  end
  
  def previous_allintitle
    title_results.order(created_at: :desc)[1].nil? ? first_allintitle : title_results.order(created_at: :desc)[1]
  end
  
  def first_allintitle
    title_results.order(created_at: :asc).first
  end
  
  def reset_allintitle
    title_results.each {|tr| tr.destroy }
  end
  
  def days_since_last_scrape
    title_results.count > 0 ? (DateTime.now.to_date - current_allintitle.created_at.to_date).to_i : 0
  end
  
  def ready_to_scrape?
    title_results.count > 0 && (DateTime.now.to_i - current_allintitle.created_at.to_i) >= 1.day.to_i ? true : false
  end
  
  def slope
    BigDecimal.new(LinearRegression.new(allintitle_list).slope.to_s)
  end
  
  def competition_level
    case title_results.average(:google_count)
    when 0
      @@competition_levels[:none]
    when 1..1000
      @@competition_levels[:low]
    when 1001..3000
      @@competition_levels[:mild]
    when 3001..6000
      @@competition_levels[:moderate]
    else
      @@competition_levels[:high]
    end
  end
  
  # def word
  #   '**OBFUSCATED NYANYANYA**'
  # end
  
end
