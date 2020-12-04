require_relative '../config/environment'
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

input = "begin"
print "Please enter username: "
username = gets.chomp
user = User.find_or_create_by(name: username)

puts "Welcome to your planner!"
while input != "quit"
    print "What would you like to do? (input 'menu' for menu options.): "
    input = gets.chomp
    case input
    when "menu"
        puts
        puts "Input 'entry' to create a new entry."
        puts "Input 'day' to view your daily schedule."
        puts "Input 'week' to view your weekly schedule."
        puts "Input 'month' to view your monthly schedule."
        puts "Input 'all' to view all your scheduled activities."
        puts "Input 'update' to update an entry."
        puts "Input 'remove' to remove an entry, or remove a group of entries."
        puts "Input 'quit' to quit out of the program."
        puts 
    when "entry"
        print "Please enter the entry's month: "
        month = gets.chomp.to_i
       
        print "Please enter the entry's day: "
        day = gets.chomp.to_i
        #binding.pry
        monthy = DateTime.new(month, day)
        entry_day = Day.where("month = ? AND day = ?", monthy.month, monthy.day).first_or_create
        #continue when booked works
    
    when "day"
        todays_month, todays_day = todays_date[0], todays_date[1]
        entry_day = Day.where("month = ? AND day = ?",todays_month,todays_day).first
        entry_day.entries.each{|entry| puts "#{entry.converted_start_time} - #{entry.converted_end_time} : #{entry.description}"}
    when "week"
        todays_month, todays_day = todays_date[0], todays_date[1]
        entry_week = [] 
        #we will need to << valid days into this array aka not days that dont exist in a month
    when "month"
        todays_month = todays_date[0]
        #uses todays date to find all days with todays month as the month.
        days_of_this_month = Day.where("month = ?",todays_month)
        days_of_this_month.each do |day|
            puts "\n#{day.month}/#{day.day}"
            entries = day.entries
            entries.each do |entry|
                puts "#{entry.converted_start_time} - #{entry.converted_end_time} : #{entry.description}"
            end
        end
    when "all"
        Entry.group(:month)

    when "update"
        date = convert_date(gets.chomp)
        Day.where("month = ? AND day = ?",date[0],date[1]).first
        
    
    when "remove"
        print "Would you like to remove an entry, day, week, month, or all entries?: "
        input = gets.chomp
        case input
        when "entry"
            print "What is the date of the entry you would like to remove?: "
            date = convert_date(gets.chomp)
            print "What is the start time of the entry you would like to remove?: "

        when "day"

        when "week"

        when "month"

        when "all entries"

        end
    
    end


    
    
    
    



end


