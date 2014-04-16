module ApplicationHelper

  def date_output(date)
    date.strftime('%e %B %Y') if date
  end
end
