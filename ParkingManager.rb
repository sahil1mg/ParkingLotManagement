require "./ParkingSpace.rb" 

def print_options
    puts "-"*40
    puts "Enter the option to choose the action."
    puts "1) Park a Vehicle"
    puts "2) Remove a Vehicle"
    puts "3) Get a vehicle's location"
    puts "4) Change vehicle's location"
    puts "5) End Program"
    puts "-"*40
end

def get_input
    gets.chomp.to_i
end


puts "Create your Parking Space";
puts "-"*50
puts "Enter number of floors needed in parking";
floor = gets.chomp.to_i
puts "Enter number of rows needed in parking";
rows = gets.chomp.to_i
puts "Enter number of columns needed in parking";
columns = gets.chomp.to_i
parking_space = ParkingSpace.new(floor, rows, columns)
puts "Your Parking Space is Created"
while true
    print_options
    option = get_input
    if (option >0 && option <6)
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
            puts "Your Parking Space has Shuts down"
            puts "X"*50
            break
        end
    else
        puts "Kindly enter a correct integer option"
    end
end
