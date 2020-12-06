require_relative '../config/environment'
require 'pry'

input = "begin"
print "Please enter username: "
username = gets.chomp
user = User.find_or_create_by(name: username)

puts "\nWelcome to your planner, #{user.name}!"

while input != "quit"
    print "\nWhat would you like to do? (input 'menu' for menu options.): "
    input = gets.chomp
    case input
    
    when "menu"
        case_menu
    
    when "entry"
        case_entry(user)
        
    when "day"
        case_day
        
    #when "week"
        ###########
    when "month"
        case_month
    
    when "all"
        case_all
    
    when "update"
        case_update
    
    when "remove"
        case_remove
    end
    



end


