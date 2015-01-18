module ApplicationHelper
  def color_for_allintitle(allintitle=0)
    case allintitle
    when 0
      ''
    when 1..1000
      'green'
    when 1001..3000
      'blue'
    when 3001..6000
      'orange'
    else
      'red'
    end
  end
  
  def list_dates_between_dates(start_date, end_date)
    (start_date..end_date).map {|d| d.strftime('%Y-%m-%d') }
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
  
  def glyphicon(icon)
    "<span class='glyphicon glyphicon-#{icon}' aria-hidden='true'></span>".html_safe
  end
  
  def up_or_down_glyphicon_for_change(change)
    return glyphicon('remove') if change == 0
    return glyphicon('arrow-up') if change > 0
    return glyphicon('arrow-down') if change < 0
  end
  
  def star_for_favorite(favorite)
    glyphicon(star_class_for_favorite(favorite))
  end
  
  def star_class_for_favorite(favorite)
    favorite ? 'star' : 'star-empty'
  end
  
  def percent_to_hex(percent, start, stop)
    colors = [start,stop].map do |c|
      c.scan(/../).map { |s| s.to_i(16) }
    end

    colors_int = colors.transpose.map do |x,y|
      (x + percent * 100 * (y - x)).round
    end

    "##{colors_int.map { |i| i.to_s(16) }.join("")}"
  end
  
end
