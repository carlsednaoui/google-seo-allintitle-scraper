module KeywordsHelper
  def csv_from_keywords(keywords)
    o = "\"Keyword\",\"All In Title\"\r\n"
    keywords.each {|k| o << "\"#{k.word}\",\"#{k.allintitle}\"#{"\r\n" unless k == keywords.last}"}
    o
  end
  
  def change(previous,current)
    current - previous
  end
  
  def color_for_change(previous, current)
    ch = change(previous, current)
    return 'red ' if ch > 0
    return 'green' if ch < 0
    return nil if ch == 0
  end
  
  def title_results_table
    
    out = "<table>"
    out << "<tr>"
    out << "<th>Date</th>"
    out << "<th>Count</th>"
    out << "<th>Change</th>"
    out << "</tr><tr>"
    
    results = @keyword.title_results
    
    previous = nil
    
    results.each do |current|
      out << "<tr>"
      out << "<td>#{current.created_at}</td>"
      out << "<td>#{current.google_count}</td>"
      out << (previous.nil? ? "<td>&nbsp;</td>" : "<td class='#{color_for_change(previous.google_count,current.google_count)}'>#{change(previous.google_count,current.google_count)}</td>")
      out << "</tr>"
      previous = current
    end
    out << "</table>"
    return out.html_safe
  end
end
