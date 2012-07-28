require 'nokogiri'
require 'open-uri'

base_url = "http://www.google.com/search?q=allintitle:"
quotes = "%22"

# Get Keyword.word
kwd = Keyword.first.word

# Replace spaces in Keyword.word proper url encoding format
kwd = kwd.gsub(" ", "%20")

# Build the URL to be passed to Nokogiri
url = base_url + quotes + kwd + quotes

doc = Nokogiri::HTML(open("#{url}"))

a = doc.css('div').first(9).last.text
a = a.gsub("Advanced searchAbout ","")
a = a.gsub(" results", "")
puts a

def run_it
	#Keyword.first(100).each do |foo|
	Keyword.where("allintitle IS NOT NULL").each do |foo|
  		base_url = "http://www.google.com/search?q=allintitle:"
  		quotes = "%22"
  		kwd = foo.word
		puts kwd
  		kwd = kwd.gsub(" ", "%20")
  		url = base_url + quotes + kwd + quotes
  		doc = Nokogiri::HTML(open("#{url}"))
  		a = doc.css('div').first(9).last.text
		puts a
  		a = a.gsub("Advanced searchAbout ","")
  		a = a.gsub(" results", "")
  		a = a.gsub(",", "")
  		foo.allintitle = a.to_i
  		foo.save!
		sleep 3+Random.rand(7).seconds
	end
end

run_it
