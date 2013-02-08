# Some date and time helper functions....
module DateFactory

  MONTHS = %w{JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC}

  # Takes a time object and returns a hash containing
  # various parts of the relevant date.
  # @param time_object [Time] the moment you want to convert
  # @returns [Hash] a hash object containing various parts of the date/time you passed to the method
  #
  def date_factory(time_object)
    {
        sakai:          make_date(time_object),
        sakai_rounded:  make_date(time_object).gsub!(/:\d+/, ":#{Time.at(time_object.to_i/(5*60)*(5*60)).strftime("%M")}"), # Date with time rounded to nearest 5-minute mark.
        short_date:     time_object.strftime("%b %-d, %Y"), # => "Oct 18, 2013"
        samigo:         time_object.strftime("%m/%d/%Y %I:%M:%S %p"), # => "10/30/2012 07:02:05 AM"
        MON:            time_object.strftime("%^b"), # => "DEC"
        Mon:            time_object.strftime("%b"), # => "Jan"
        Month:          time_object.strftime("%B"), # => "February"
        month_int:      time_object.month, # => 3
        day_of_month:   time_object.day, # => 17 Note this is not zero-padded
        weekday:        time_object.strftime("%A"), # => "Monday"
        wkdy:           time_object.strftime("%a"), # => "Tue"
        year:           time_object.year, # => 2013
        hour:           time_object.strftime("%I").to_i, # => "07" Zero-padded, 12-hour clock
        minute:         time_object.strftime("%M"), # => "02" Zero-padded
        minute_rounded: (Time.at(time_object.to_i/(5*60)*(5*60))).strftime("%M"), # => "05" Zero-padded, rounded to 5-minute increments
        meridian:       time_object.strftime("%P"), # => "pm"
        MERIDIAN:       time_object.strftime("%p"), # => "AM"
        date_w_slashes: time_object.strftime("%m/%d/%Y"), # => 02/08/2013
        custom:         time_object # => Allows creation of a custom date string using the passed time value.
    }
  end

  def an_hour_ago
    date_factory(Time.now - 3600)
  end
  alias last_hour an_hour_ago

  def right_now
    date_factory(Time.now)
  end

  def in_an_hour
    date_factory(Time.now + 3600)
  end
  alias next_hour in_an_hour

  def last_year
    date_factory(Time.now - (3600*24*365))
  end
  alias a_year_ago last_year

  # Returns a randomly selected date/time from
  # within the last year.
  def in_the_last_year
    date_factory(Time.random(:year_range=>1))
  end

  def last_month
    index = MONTHS.index(current_month)
    return MONTHS[index-1]
  end

  def hours_ago(hours)
    date_factory(Time.now - hours*3600)
  end

  def hours_from_now(hours)
    date_factory(Time.now + hours*3600)
  end

  # Takes an integer representing
  # the count of minutes as the parameter, and
  # returns the date_factory hash for the
  # resulting Time value.
  #
  def minutes_ago(mins)
    date_factory(Time.now - mins*60)
  end

  def minutes_from_now(mins)
    date_factory(Time.now + mins*60)
  end

  # Returns the current month as an
  # upper-case 3-letter string.
  # example: "JUL"
  #
  def current_month
    Time.now.strftime("%^b")
  end

  def next_month
    index = MONTHS.index(current_month)
    if index < 11
      return MONTHS[index+1]
    else
      return MONTHS[0]
    end
  end

  def in_a_year
    date_factory(Time.now + (3600*24*365))
  end
  alias next_year in_a_year

  def yesterday
    date_factory(Time.now - (3600*24))
  end

  def tomorrow
    date_factory(Time.now + (3600*24))
  end

  def in_a_week
    date_factory(Time.now + (3600*24*7))
  end
  alias next_week in_a_week

  def a_week_ago
    date_factory(Time.now - (3600*24*7))
  end

  def next_monday
    date_factory(Time.at(Time.now+(8-Time.now.wday)*24*3600))
  end

  # Formats a date string Sakai-style.
  # Useful for verifying creation dates and such.
  #
  # @param time_object [Time] the moment that you want converted to the string
  # @returns [String] a date formatted to look like this: Jun 8, 2012 12:02 pm
  #
  def make_date(time_object)
    month = time_object.strftime("%b ")
    day = time_object.strftime("%-d")
    year = time_object.strftime(", %Y ")
    mins = time_object.strftime(":%M %P")
    hour = time_object.strftime("%l").to_i
    return month + day + year + hour.to_s + mins
  end

end