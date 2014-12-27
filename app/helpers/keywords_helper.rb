module KeywordsHelper
  def csv_from_keywords(keywords)
    o = "\"Keyword\",\"All In Title\"\r\n"
    keywords.each {|k| o << "\"#{k.word}\",\"#{k.allintitle}\"#{"\r\n" unless k == keywords.last}"}
    o
  end
end
