module ApplicationHelper
  def event_time_format(event_time)
    time = distance_of_time_in_words_hash(Time.now.utc, event_time)

    days = time["days"] ||= 0
    hours = time["hours"] ||= 0
    mins = time["minutes"] ||= 0

    if event_time < Time.now.utc
      "#{hours}h #{mins}m ago"
    elsif days < 1
      "in #{hours}h #{mins}m"
    else
      "#{pluralize(days, "day")}"
    end
  end

  def time_ago_from_now(from_time)
    distance_in_minutes = ((Time.now - from_time)/60.0).round

    case distance_in_minutes
      when 0..59
        return "#{distance_in_minutes}m"
      when 60...1440
        return "#{distance_in_minutes/60}h"
      when 1440...2520
        return "1d"
      when 2520...43200
        return "#{(distance_in_minutes.to_f / 1440.0).round}d"
      when 43200...86400
        return "about #{(distance_in_mintes.to_f / 43200.0).round} months"
      when 86400...525600
        return "#{(distance_in_mintes.to_f / 43200.0).round} months"
      else
        "a long time"
    end
  end

  def get_image(object)
    if !object.image_url.nil?
      object.image_url.to_s
    else
      image_path('placeholder.png')
    end

  end
end
