module ApplicationHelper
  def flash_color(type)
    case type
    when 'notice'
      'rgb(156, 219, 156)'
    when 'error'
      'rgba(219, 150, 155, 1)'
    when 'warning', 'alert'
      'rgba(237, 237, 164, 1)'
    else
      'rgba(227, 223, 214, 1)'
    end
  end
end

