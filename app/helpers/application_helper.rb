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

  def get_image(object)
    if !object.image_url.nil?
      object.image_url.to_s
    else
      image_path('placeholder.png')
    end

  end
end
