module ApplicationHelper
  def randomized_background_image
    images = ["assets/backgrounds/1.jpg", "assets/backgrounds/2.jpg", "assets/backgrounds/3.jpg",
              "assets/backgrounds/4.jpg", "assets/backgrounds/5.jpg", "assets/backgrounds/6.jpg", 
              "assets/backgrounds/7.jpg", "assets/backgrounds/8.jpg", "assets/backgrounds/9.jpg"]

    images[rand(images.size)]
  end

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
      elsif days == 1
        event_time.strftime("Yesterday at %l:%M%p") +  " (#{24+hours}h ago)"
      elsif months <= 1
        event_time.strftime("%m-%d-%Y") + " (#{pluralize(days, "day")} ago)"
      elsif years < 1
        event_time.strftime("%m-%d-%Y") + " (#{pluralize(months, "month")} ago)"
      else
        event_time.strftime("%m-%Y") + " (over #{pluralize(years, "year")} ago)"
      end
    else
      if years > 1
        event_time.strftime("%m-%Y") + " (in #{pluralize(years, "year")})"
      elsif months > 1
        event_time.strftime("%m-%d-%Y") + " (in #{pluralize(months, "month")})"
      elsif months == 1
        event_time.strftime("%m-%d") + " (in #{pluralize(total_days, "day")})"
      elsif days > 7
        event_time.strftime("%m-%d") + " (in #{pluralize(days, "day")})"
      elsif days > 1
        event_time.strftime("%m-%d at %l:%M%p") + " (in #{pluralize(days, "day")})"
      elsif days == 1
        event_time.strftime("%m-%d at %l:%M%p") +  " (in #{24+hours}h)"
      elsif hours > 1
        event_time.strftime("%m-%d at %l:%M%p") +  " (in #{hours}h)"
      elsif mins > 1
        event_time.strftime("Today at %l:%M%p") + " (in #{mins} minutes)"
      else
        event_time.strftime("Today at %l:%M%p") + " (starting now!)"
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

  def get_event_name(event)
    if event.name.length < 10
      "#{event.tournament.name}: #{event.name}"
    else
      event.name
    end
  end

  def tournament_date_range(tournament)
    if tournament.end_date
      "#{tournament.start_date.strftime("%m-%d-%Y")} to #{tournament.end_date.strftime("%m-%d-%Y")}"    
    else
      "#{tournament.start_date.strftime("%m-%d-%Y")}"    
    end
  end

  def convert_prize_pool(tournament)
    user_currency = signed_in? ? current_user.currency_iso_code : "USD"
    tournament.prize_pool.exchange_to(user_currency)
  end

  def calculate_total_prizes(tournaments)
    currency = signed_in? ? current_user.currency_iso_code : "USD"

    begin
      total = tournaments.collect { |t| t.prize_pool }.inject(:+)

    rescue Money::Bank::UnknownRate
      #Just use USD if conversion rate not found
      return tournaments.collect { |t| t.prize_pool }.inject(:+).exchange_to("USD")
    end

    total ? total.exchange_to(currency) : 0
    
  end
end
