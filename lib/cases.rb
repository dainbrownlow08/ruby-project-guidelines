require 'pry'
def case_menu
    puts
    puts "                   M         E         N         U                  "
    puts "|------------------------------------------------------------------|"
    puts "| Input 'entry' to create a new entry.                             |"
    puts "| Input 'day' to view your daily schedule.                         |"
    #puts "|Input 'week' to view your weekly schedule.                        |"
    puts "| Input 'month' to view your monthly schedule.                     |"
    puts "| Input 'all' to view all your scheduled activities.               |"
    puts "| Input 'update' to update an entry.                               |"
    puts "| Input 'remove' to remove an entry.                               |"
    puts "| Input 'quit' to quit out of the program.                         |"
    puts "|------------------------------------------------------------------|"
end

def case_entry(user)
    print "Please enter the entry's month: "
    month = gets.chomp
    while !valid_month?(month)
        print "This is not a valid month. Please provide a month from #{todays_date[0]} to 12: "
        month = gets.chomp
    end
   
    print "Please enter the entry's day: "
    day = gets.chomp
    while !valid_day?(month,day)
        print "This is not a valid day. Please provide a valid day: "
        day = gets.chomp
    end
    entry_day = Day.find_or_create_by(:month => month, :day => day)
    
    print "Please enter your activity's desired start time(please use 24hr time HH:MM): "
    start_time = convert_hour_to_min(gets.chomp)
    print "Please enter your activity's desired end time(please use 24hr time HH:MM): "
    end_time = convert_hour_to_min(gets.chomp)
    time = [start_time,end_time]
    if valid_time?(time,entry_day) == true
        print "Please enter a short description for your activity: "
        description = gets.chomp
        new_entry = Entry.create()
        new_entry.start_time = start_time
        new_entry.end_time = end_time
        new_entry.description = description
        new_entry.user_id = user.id
        new_entry.day_id = entry_day.id
        new_entry.save
        puts "\n Schedule updated."
    else 
        puts "\nThis is not a valid time. Try again."
    end
end

def case_day
    todays_month, todays_day = todays_date[0], todays_date[1]
    entry_day = Day.where("month = ? AND day = ?",todays_month,todays_day).first
    if entry_day.entries == []
        puts "\nYour schedule is empty today"  
    else
        entry_day.entries.sort_by{|entry| entry.start_time}.each{|entry| puts "\n#{entry.converted_start_time} - #{entry.converted_end_time} : #{entry.description}"}
    end
end

def case_month
    todays_month = todays_date[0]
    days_of_this_month = Day.where("month = ?",todays_month)
    days_of_this_month.each do |day|
        puts "\n#{day.month}/#{day.day}"
        entries = day.entries.sort_by{|entry| entry.start_time}
        entries.each do |entry|
            puts "\n#{entry.converted_start_time} - #{entry.converted_end_time} : #{entry.description}"
        end
    end
end

def case_all
    entry_by_day = Entry.order(:day_id).group_by{|entry| entry.day_id}
    index = entry_by_day.keys[0]
    entry_by_day.count.times do
        puts "\n#{Day.all.find{|day| day.id == index}.month}/#{Day.all.find{|day| day.id == index}.day}"
        entries = entry_by_day[index].sort_by{|entry| entry.start_time}.each{|entry| puts "\n#{entry.converted_start_time} - #{entry.converted_end_time} : #{entry.description}"}
        index +=1
    end
end

def case_update
    print "Please enter the target entry's month: "
    month = gets.chomp
    while !valid_month?(month)
        print "This is not a valid month. Please provide a month from #{todays_date[0]} to 12: "
        month = gets.chomp
    end
    if any_month_entries(month) == false
        puts "\nThere are no entries this month."
        return
    
    end
    print "Please enter the target entry's day: "
    day = gets.chomp
    while !valid_day?(month,day)
        print "This is not a valid day. Please provide a valid day: "
        day = gets.chomp
    end
    if Day.all.find_by(:day => day) == nil
        puts "You have not made an entry for this day."
        return
    end
    day_to_update = Day.all.find_by(:day => day)
    day_to_update.entries.sort_by{|entry| entry.start_time}.each{|entry| puts "\n#{entry.converted_start_time} - #{entry.converted_end_time} : #{entry.description}"}
    
    print "\nWhat is the start time of the entry you would like to update?(please use 24hr time HH:MM): "
    chosen_time = convert_hour_to_min(gets.chomp)
    while day_to_update.entries.find{|entry| entry.start_time == chosen_time} == nil
        print "\nThere is no entry with this start time, please try again(please use 24hr time HH:MM): "
        chosen_time = convert_hour_to_min(gets.chomp)
    end
    entry_to_update = day_to_update.entries.find{|entry| entry.start_time == chosen_time}
    print "\nWhat is the new start time of the entry?(please use 24hr time HH:MM): "
    start_time = convert_hour_to_min(gets.chomp)
    print "\nWhat is the new end time of the entry?(please use 24hr time HH:MM): "
    end_time = convert_hour_to_min(gets.chomp)
    time = [start_time,end_time]
    if valid_time?(time,day_to_update) == true
        entry_to_update.update(start_time: start_time, end_time: end_time)
        day_to_update.entries.sort_by{|entry| entry.start_time}.each{|entry| puts "\n#{entry.converted_start_time} - #{entry.converted_end_time} : #{entry.description}"}
        puts "\n Schedule updated."
    else 
        puts "\nThis is not a valid time. Try again."
    end
end

def case_remove
    print "Please enter the target entry's month: "
    month = gets.chomp
    while !valid_month?(month)
        print "This is not a valid month. Please provide a month from #{todays_date[0]} to 12: "
        month = gets.chomp
    end
    if any_month_entries(month) == false
        puts "\nThere are no entries this month."
        return
    
    end
    print "Please enter the target entry's day: "
    day = gets.chomp
    while !valid_day?(month,day)
        print "This is not a valid day. Please provide a valid day: "
        day = gets.chomp
    end
    if Day.all.find_by(:day => day) == nil
        puts "You have not made an entry for this day."
        return
    end
    day_to_remove_from = Day.all.find_by(:day => day)
    day_to_remove_from.entries.sort_by{|entry| entry.start_time}.each{|entry| puts "\n#{entry.converted_start_time} - #{entry.converted_end_time} : #{entry.description}"}
    
    print "\nWhat is the start time of the entry you would like to delete?(please use 24hr time HH:MM): "
    chosen_time = convert_hour_to_min(gets.chomp)
    while day_to_remove_from.entries.find{|entry| entry.start_time == chosen_time} == nil
        print "\nThere is no entry with this start time, please try again(please use 24hr time HH:MM): "
        chosen_time = convert_hour_to_min(gets.chomp)
    end
    entry_to_destroy = day_to_remove_from.entries.find{|entry| entry.start_time == chosen_time}.destroy
    puts "\n Entry removed."
end



