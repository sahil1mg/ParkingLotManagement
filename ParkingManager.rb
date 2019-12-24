require "./ParkingSpace.rb" 
require "./CommonFunc.rb"

def print_options
    puts "-"*40
    puts "Enter the option to choose the action."
    puts "1) Park a Vehicle"
    puts "2) Remove a Vehicle"
    puts "3) Get a vehicle's location"
    puts "4) Change vehicle's location"
    puts "5) Print Parking Space"
    puts "6) Get Total of Transactions"
    puts "7) End Program"
    puts "-"*40
end

def get_input
    gets.chomp.to_i
end


puts "Create your Parking Space";
puts "-"*50
puts "Enter number of floors needed in parking";
floor = get_int
puts "Enter number of rows needed in parking";
rows = get_int
puts "Enter number of columns needed in parking";
columns = get_int
parking_space = ParkingSpace.new(floor, rows, columns)
puts "Your Parking Space is Created"
while true
    print_options
    option = get_input
    if (option >0 && option <8)
        i_option = option.to_i
        case i_option
        when 1
            parking_space.park
        when 2
            parking_space.unpark
        when 3
            parking_space.get_location
        when 4
            parking_space.change_location
        when 5
            parking_space.print_parking_space
        when 6
            puts "Rs. #{parking_space.money_earned}"
        when 7
            puts "Your Parking Space has Shuts down"
            puts "X"*50
            break
        end
    else
        puts "Kindly enter a correct integer option"
    end
end
