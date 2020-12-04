#returns today's date as an array of strings in format [month_string,day_string]
def todays_date
    todays_date = Time.now.to_s.split(" ")[0].split("-")
    date = [todays_date[1],todays_date[2]]
end

#converts a MM/DD formatted string date
def convert_date(string_date)
    string_date = string_date.split("/")
    date = [string_date[0],string_date[1]]
end

#converts a HH:MM formatted time string to minutes after midnight
def convert_hour_to_min(time_string)
    time_string = time_string.split(":")
    hour = time_string[0].to_i
    min = time_string[1].to_i
    min_since_midnight = hour*60 + min
end

#checks if month is between 1 and 12
def valid_month?(month)
    if month.to_i > 12 || month.to_i < 1
        false  
    else
        true
    end
end

#checks if time is valid using minutes after midnight
def valid_time?(time)
    if time.to_i > 1440 || time.to_i < 1
        false
    else 
        true
    end
end

#checks if day is valid for month
def valid_day?(month,day)
    month = month.to_i
    day = day.to_i
    case month
    when 1
        if day > 31 || day < 1
            false  
        else
            true
        end
    when 2
        if day > 28 || day < 1
            false  
        else
            true
        end
    when 3
        if day > 31 || day < 1
            false  
        else
            true
        end
    when 4
        if day > 30 || day < 1
            false  
        else
            true
        end
    when 5
        if day > 31 || day < 1
            false  
        else
            true
        end
    when 6
        if day > 30 || day < 1
            false  
        else
            true
        end
    when 7
        if day > 31 || day < 1
            false  
        else
            true
        end
    when 8
        if day > 31 || day < 1
            false  
        else
            true
        end
    when 9
        if day > 30 || day < 1
            false  
        else
            true
        end
    when 10
        if day > 31 || day < 1
            false  
        else
            true
        end
    when 11
        if day > 30 || day < 1
            false  
        else
            true
        end
    when 12
        if day > 31 || day < 1
            false  
        else
            true
        end
    end
end







