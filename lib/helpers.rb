
#Uses Time.now to grab todays date. Returns in format ["month","day"].
def todays_date
    todays_date = Time.now.to_s.split(" ")[0].split("-")
    date = [todays_date[1],todays_date[2]]
end

#Converts a string date argument in format "MM/DD". 
#params: 
# - string_date : String represendation of a date in format "MM/DD".
#returns: string_date in format ["month","day"].
def convert_date(string_date)
    string_date = string_date.split("/")
    date = [string_date[0],string_date[1]]
end

#Converts a time string in format "HH:MM". 
#params:
# - time_string : String representing a numerical hour value, using 24 hour time.
#returns: Integer of the time in minutes past midnight.
def convert_hour_to_min(time_string)
    time_string = time_string.split(":")
    hour = time_string[0].to_i
    min = time_string[1].to_i
    min_since_midnight = hour*60 + min
end

#Checks if a user provided month is between 1 and 12.
#params:
# - month : String representing a numerical month value. ex: "12"
#returns: Boolean if month is not an actual calendar month.
def valid_month?(month)
    if month.to_i > 12 || month.to_i < 1
        false
    else
        true
    end
end

#Checks if a time array arguement conflicts with a users schedule, is not within daily bounds, or begins after it ends.
#Calls method valid_times
#params: 
# - time_array : Array of two integer elements, the start time and end time, as minutes after midnight.
# - day : Instance of Day class. Used to find day's entries.
# - user : Instance of User class. Refers to the user that is logged in.
#returns: Boolean if time_array conflicts with schedule.
def valid_time?(time_array,day,user)
    bounds_check = time_array.select{|time| time > 1400 || time < 0}
    if bounds_check.length > 0
        false
        return
    end
    if time_array[0] > time_array[1]
        false
        return
    end
    valid_times = valid_times(day,user)
    if valid_times.find{|slot| time_array[0] >= slot[0] && time_array[1] <= slot[1]} != nil
        true
    else 
        false
    end
end

#Creates an AoA of avialible time slots in a days schedule.
#params:
# - day : Instance of Day class. Used to find day's entries.
# - user : Instance of User class. Refers to the user that is logged in.
#returns: An AoA of a users avaible time slots for that day, with each time slot represented as an array with
# a start and end time in minutes fater midnight.
def valid_times(day,user)
    if day.entries.select{|entry| entry.user_id == user.id}.length == 0
        validTimes = [[0,24*60]]
    else 
        schedule = day.entries.select{|entry| entry.user_id == user.id}.map{|entry| [entry.start_time,entry.end_time]}
        validTimes = [[0,0]]
        if schedule[0][0] > 0
            validTimes[0][0] = 0
            validTimes[0][1] = schedule[0][0]
            (schedule.length-1).times do |i|
                validTimes << []
                validTimes[i+1][0] = schedule[i][1]
                validTimes[i+1][1] = schedule[i+1][0]
            end
            validTimes << [schedule.last[1], 24*60]
        else
            validTimes[0][0] = schedule[0][1]
            validTimes[0][1] = schedule[1][0]
            (schedule.length-2).times do |i|
                validTimes << []
                validTimes[i+1][0] = schedule[i+1][1]
                validTimes[i+1][1] = schedule[i+2][0]
            end
        end
        validTimes << [schedule.last[1], 24*60] if schedule.last[1] != 24*60
    end
end

#Checks is there are any entries in a users's monthly schedule.
#Calls method any_day_entries?
#params:
# - month_string : String representing a numerical month value. ex: "12"
# - user : Instance of User class. Refers to the user that is logged in.
#returns: Boolean if the user has any entries in the month's schedule.
def any_month_entries(month_string,user)
    if Day.all.find{|day| day.month == month_string.to_i} != nil
        days_this_month = Day.all.select{|day| day.month == month_string.to_i}
        if days_this_month.select{|day| any_day_entries?(day,user)} == []
            false
        else
            true
        end
    else 
        false
    end
end

#Checks if there are any entries for a given day, and given user.
#params:
# - day_obj : Instance of Day class. Used to find day's entries.
# - user : Instance of User class. Refers to the user that is logged in.
#returns: Boolean if the given user has any entries for the given day.
def any_day_entries?(day_obj,user)
    if Day.all.find{|day| day.day == day_obj.day} == nil
        false
    else 
        this =  Day.all.find{|day| day.day == day_obj.day}
        if this.entries.select{|entry| entry.user_id == user.id} == []
            false
        else
            true
        end
    end

end

#Checks if a given day is valid for a given month, using non-leap year month lengths.
#params:
# - month : String representing a numerical month value. ex: "12"
# - day : String representing a numerical day value. ex: "5"
#returns: Boolean if the day exists in that month.
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







