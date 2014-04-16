module ApplicationHelper

  def date_output(date)
    date.strftime('%e %B %Y') if date
  end

  def time_output(time)
    time.strftime('%H:%M') if time
  end
end
