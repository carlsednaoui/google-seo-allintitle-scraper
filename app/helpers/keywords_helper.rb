module KeywordsHelper
  def csv_from_keywords(keywords)
    o = "\"Keyword\",\"All In Title\"\r\n"
    keywords.each {|k| o << "\"#{k.word}\",\"#{k.allintitle}\"#{"\r\n" unless k == keywords.last}"}
    o
  end
  
  def color_for_allintitle(allintitle=0)
    case allintitle
    when 0
      ''
    when 1..1000
      'green'
    when 1001..2000
      'orange'
    else
      'red'
    end
  end
end
