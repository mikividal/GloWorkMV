module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    markdown.render(text).html_safe
  end

  def mood_trend_text(mood, change)
    mood_icon = { happy: "😀", neutral: "😐", sad: "☹️" }[mood]

    if change.positive?
      trend = "↑"
      description = "more"
    elsif change.negative?
      trend = "↓"
      description = "less"
    else
      trend = "→"
      description = "same"
    end

    "#{change.abs}% #{description} #{mood}"
  end

  def filtered_moodtrackers_by(moods, range, previous: false)
    case range
    when "6months"
      from = previous ? 1.year.ago : 6.months.ago
      to = previous ? 6.months.ago : Time.current
    when "1month"
      from = previous ? 2.months.ago : 1.month.ago
      to = previous ? 1.month.ago : Time.current
    when "7days"
      from = previous ? 14.days.ago : 7.days.ago
      to = previous ? 7.days.ago : Time.current
    else
      return moods
    end

    moods.where(date: from..to)
  end
end
