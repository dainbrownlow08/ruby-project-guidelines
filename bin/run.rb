require_relative '../config/environment'
require 'pry'

input = "begin"
print "Please enter username: "
username = gets.chomp
user = User.find_or_create_by(name: username)
landing
puts "\n Welcome to your planner,"+" #{user.name}".colorize(:blue)+"!"

while input != "quit"
    print "\nWhat would you like to do? (input 'menu' for menu options.): "
    input = gets.chomp
    case input
    
    when "menu"
        case_menu
    
    when "entry"
        case_entry(user)
        
    when "day"
        case_day(user)

    when "month"
        case_month(user)
    
    when "all"
        case_all(user)
    
    when "update"
        case_update(user)
    
    when "remove"
        case_remove(user) 
    
    when "quit"
        case_quit(user)
    
    else
        case_all_other_inputs

    end
end


