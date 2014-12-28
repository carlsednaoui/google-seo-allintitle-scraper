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
end
