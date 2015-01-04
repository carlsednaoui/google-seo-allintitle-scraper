module KeywordsHelper
  def csv_from_keywords(keywords)
    o = "\"Keyword\",\"All In Title\",\"Scraped Date\"\r\n"
    keywords.each {|k| o << "\"#{k.word}\",\"#{k.allintitle.google_count}\",\"#{k.allintitle.created_at.strftime('%Y-%m-%d')}\"#{"\r\n" unless k == keywords.last}"}
    o
  end
  
  def change(previous,current)
    current - previous
  end
  
  def percent_change(previous,current)
    change(previous,current) == 0 ? 0 : ((BigDecimal.new(current) / BigDecimal.new(previous)) - 1) * 100
  end
  
  def color_for_change(change)
    return 'red ' if change > 0
    return 'green' if change < 0
    return nil if change == 0
  end
  
  def color_for_percent_change(percent_change)
    return '#000' if percent_change == 0
    return "rgb(#{(100 * (percent_change / 100)).to_i + 155},0,0); /* greater than 0 /*" if percent_change > 0
    return "rgb(0,#{(100 * ((percent_change - percent_change - percent_change) / 100)).to_i + 155},0); /* less than 0 /*" if percent_change < 0
  end
  
  def title_results_table
    
    out = "<table class='table table-striped'>"
    out << "<tr>"
    out << "<th>Date</th>"
    out << "<th>Count</th>"
    out << "<th>% Change</th>"
    out << "<th>Change</th>"
    out << "</tr>"
    
    results = @keyword.title_results
    
    previous = nil
    
    results.each do |current|
      out << "<tr>"
      out << "<td>#{current.created_at.strftime('%Y-%m-%d')}</td>"
      out << "<td class='#{color_for_allintitle(current.google_count)}'>#{current.google_count}</td>"
      out << (previous.nil? ? "<td>0.00%</td>" : "<td style = \"color: #{color_for_percent_change(percent_change(previous.google_count,current.google_count))}\">#{number_to_percentage(percent_change(previous.google_count,current.google_count), precision: 2)}</td>")
      out << (previous.nil? ? "<td>0</td>" : "<td class='#{color_for_change(change(previous.google_count,current.google_count))}'>#{change(previous.google_count,current.google_count)}</td>")
      out << "</tr>"
      previous = current
    end
    out << "</table>"
    return out.html_safe
  end
end
