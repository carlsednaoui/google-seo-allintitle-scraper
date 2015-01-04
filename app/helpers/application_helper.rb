module ApplicationHelper
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
  
  def list_dates_between_dates(start_date, end_date)
    (start_date..end_date).map {|d| d.strftime('%Y-%m-%d') }
  end
  
  def glyphicon(icon)
    "<span class='glyphicon glyphicon-#{icon}' aria-hidden='true'></span>".html_safe
  end
  
end
