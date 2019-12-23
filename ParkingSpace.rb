require "./Vehicles.rb"
class ParkingSpace
    attr_reader :floor, :rows, :columns, :space, :money_earned

    def initialize(floor, rows, columns)
        @floor = floor
        @rows = rows
        @columns = columns
        @space = Hash.new
    end

    def get_int()
        input = 0;
        while(true)
            input = gets.chomp.to_i
            if(input==0)
                puts "Kindly enter a correct number"
            else
                break
            end
        end
        return input
    end

    def park()
        puts "You have chosen Parking Option"
        key = get_parking_address
        if(space.has_key? key)
            puts "This space is already taken";
            puts "Kindly choose a new space";
            self.park
        else
            park_core key, get_validated_car_number
            puts "*"*50
            puts "Your Vehicle is parked"
            puts "*"*50
            puts "Logger : #{space}"
        end
    end

    def unpark
        puts "You have chosen Un-Park Option"
        puts "Kindly choose from the option below"
        puts "1) Un-Park using Vehicle Number"
        puts "2) Un-Park using Parking address"
        puts "3) Cancel Unpark"
        option = gets.chomp.to_i
        case option
        when 1
            unpark_using_car_number
        when 2
            unpark_using_parking_address
        when 3
            return
        else
            self.unpark
        end
    end

    def get_location
        puts "Get Location of Vehicle"
        car_number = get_validated_car_number
        if(space.has_value? car_number)
            key = space.index(car_number)
            print_parking_address_from_key key
        else
            puts "This Vehicle is not parked in this parking space"
        end
    end

    def change_location
        puts "Change Location of Vehicle"
        car_number = get_validated_car_number
        unless(space.has_value? car_number)
            puts "Vehicle is not parked in this parking space"
            return
        end
        puts "Enter new location"
        new_key = get_parking_address
        if(space.has_key? new_key)
            puts "This parking space is already in use"
            return
        end
        unpark_using_car_number_core car_number
        park_core new_key, car_number 
    end

    private

    def get_validated_car_number
        puts "Kindly enter your Vehicle number : (Format -> 'AA 12 A 1234')"
        car_number = gets.chomp
        if(car_number.match(/^[a-zA-Z]{2}\s\d{2,3}\s[a-zA-Z]{1,3}\s\d{4}$/))
            return car_number
        else
            return get_validated_car_number
        end
    end

    def unpark_using_car_number
        car_number = get_validated_car_number
        if(space.has_value? car_number)
            unpark_using_car_number_core car_number
            puts "*"*50
            puts "Vehicle : #{car_number} has been unparked"
            puts "*"*50
            puts "logger : #{space}"
        else
            puts "Vehicle number doesn't exist, Returning to unpark menu"
            self.unpark
        end
    end

    def unpark_using_car_number_core(car_number)
        key = space.index(car_number)
        space.delete(key)
    end

    def unpark_using_parking_address
        puts "You have chosen un-park using parking address"
        key = get_parking_address
        if(space.has_key? key)
            car_number = space[key]
            space.delete(key)
            puts "Vehicle : #{car_number} has been unparked"
            puts "logger : #{space}"
        else
            puts "Parking Address is empty, Returning to unpark menu"
            self.unpark
        end
    end

    def get_parking_address
        floor_no = get_floor
        row_no = get_row_no
        column_no = get_column_no
        key = "#{floor_no}_#{row_no}_#{column_no}"
    end

    def get_floor
        puts "Enter Floor at which vehicle needs to be parked (Floors Allowed - 0..#{floor-1}";
        floor_no = gets.chomp.to_i
        if (floor_no < 0 || floor_no >= floor)
            puts "invalid floor number"
            return get_floor
        end
        return floor_no
    end

    def get_row_no
        puts "Enter Row at which vehicle needs to be parked (Rows Allowed - 1..#{rows}";
        row_no = get_int
        if (row_no < 0 || row_no > rows)
            puts "invalid row number"
            return get_row_no
        end
        return row_no
    end

    def get_column_no
        puts "Enter Column at which vehicle needs to be parked (Columns Allowed - 1..#{columns}";
        column_no = get_int
        if (column_no < 0 || column_no > columns)
            puts "invalid column number"
            return get_column_no
        end
        return column_no
    end

    def print_parking_address_from_key(key)
        array = key.split('_');
        puts "Floor : #{array[0]} Row : #{array[1]} Column : #{array[2]}"
    end

    def park_core(key, car_number)
        space[key]=car_number
    end
end
