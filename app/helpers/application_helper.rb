module ApplicationHelper
  def event_time_format(event_time, raw=false)
    time = distance_of_time_in_words_hash(Time.now, event_time)

    years = time["years"] ||= 0
    months = time["months"] ||= 0
    days = time["days"] ||= 0
    total_days = Time.days_in_month(event_time.month, event_time.year) + days
    hours = time["hours"] ||= 0
    mins = time["minutes"] ||= 0

    if raw
      return "y:#{years}, m:#{months}, d:#{days}, h:#{hours} | " + time_ago_in_words(event_time)
    end

    if event_time < Time.now
      if days < 1
        event_time.strftime("Today at %l:%M%p") +  " (live #{hours}h #{mins}m ago)"
      elsif months <= 1
        event_time.strftime("%m-%d-%Y") + " (#{pluralize(total_days, "day")} ago)"
      elsif years < 1
        event_time.strftime("%m-%d-%Y") + " (#{pluralize(months, "month")} ago)"
      else
        event_time.strftime("%m-%Y") + " (over #{pluralize(years, "year")} ago)"
      end
    else
      if hours < 1
        event_time.strftime("Today at %l:%M%p") + " (in #{mins} minutes)"
      elsif days < 1
        event_time.strftime("Today at %l:%M%p") + " (in #{hours}h #{mins}m)"
      elsif months <= 1
        event_time.strftime("%m-%d") + " (in #{pluralize(total_days, "day")})"
      elsif years < 1
        event_time.strftime("%m-%d-%Y") + " (in #{pluralize(months, "month")})"
      else
        event_time.strftime("%m-%Y") + " (in #{pluralize(years, "year")})"
      end
    end
  end

  def time_ago_from_now(from_time)
    distance_in_minutes = ((Time.now - from_time)/60.0).round

    case distance_in_minutes
      when 0..1
        return "just now"
      when 1..59
        return "#{distance_in_minutes}m ago"
      when 60...1440
        return "#{distance_in_minutes/60}h ago"
      when 1440...2520
        return "yesterday"
      when 2520...43200
        return "#{(distance_in_minutes.to_f / 1440.0).round} days ago"
      when 43200...86400
        return "about #{(distance_in_mintes.to_f / 43200.0).round} months ago"
      when 86400...525600
        return "#{(distance_in_mintes.to_f / 43200.0).round} months ago"
      else
        "a long time ago"
    end
  end

  def get_event_time(event_time)
    #feed_item.event_time.strftime("%m/%d at %l:%m%p") %> (<%= event_time_format(feed_item.event_time)")
  end


  def get_event_name(event)
    if event.name.length < 10
      "#{event.tournament.name}: #{event.name}"
    else
      event.name
    end
  end

  def calculate_total_prizes(tournaments)
    tournaments.collect { |t| humanized_money_with_symbol t.prize_pool.exchange_to("USD") }.inject(:+)
  end
end
