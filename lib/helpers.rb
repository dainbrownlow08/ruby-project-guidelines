#returns today's date as an array of strings in format [month_string,day_string]
require 'pry'
def todays_date
    todays_date = Time.now.to_s.split(" ")[0].split("-")
    date = [todays_date[1],todays_date[2]]
end

def convert_date(string_date)
    string_date = string_date.split("/")
    date = [string_date[0],string_date[1]]
end

def convert_hour_to_min(time_string)
    time_string = time_string.split(":")
    hour = time_string[0].to_i
    min = time_string[1].to_i
    min_since_midnight = hour*60 + min
end

def valid_month?(month)
    if month.to_i > 12 || month.to_i < 1
        false
    #elsif month.to_i < todays_date[0].to_i
        #false 
    else
        true
    end
end

def valid_time?(time_array,day,user)
    bounds_check = time_array.select{|time| time > 1400 || time < 0}
    if bounds_check.length > 0
        false
    end
    if time_array[0] > time_array[1]
        false
    end
    valid_times = valid_times(day,user)
    if valid_times.find{|slot| time_array[0] >= slot[0] && time_array[1] <= slot[1]} != nil
        true
    else 
        false
    end
end

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

#checks is there are any entries that month
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

#checks if day is valid for month
def valid_day?(month,day)
    true
    # month = month.to_i
    # day = day.to_i
    # if day < todays_date[1].to_i
    #     false
    # else
    #     case month
    #     when 1
    #         if day > 31 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 2
    #         if day > 28 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 3
    #         if day > 31 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 4
    #         if day > 30 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 5
    #         if day > 31 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 6
    #         if day > 30 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 7
    #         if day > 31 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 8
    #         if day > 31 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 9
    #         if day > 30 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 10
    #         if day > 31 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 11
    #         if day > 30 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     when 12
    #         if day > 31 || day < 1
    #             false  
    #         else
    #             true
    #         end
    #     end
    # end
end







