require "./ParkingSpace.rb" 
require "./CommonFunc.rb"

class ParkingManager

    attr_accessor :parking_space

    def initialize 
        self.parking_space=nil
    end

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

    def execute
        puts "Create your Parking Space";
        puts "-"*50
        puts "Enter number of floors needed in parking";
        floor = get_int
        puts "Enter number of rows needed in parking";
        rows = get_int
        puts "Enter number of columns needed in parking";
        columns = get_int
        self.parking_space= ParkingSpace.new(floor, rows, columns)
        puts "Your Parking Space is Created"
        while true
            print_options
            option = get_input
            if (option >0 && option <8)
                i_option = option.to_i
                case i_option
                when 1
                    park
                when 2
                    unpark
                when 3
                    get_location
                when 4
                    change_location
                when 5
                    print_parking_space
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
    end

    def park
        puts "You have chosen Parking Option"
        vehicle = get_vehicle_type get_validated_car_number
        park_main vehicle
    end

    def park_main(vehicle)
        key = get_parking_address
        if(can_park? key, vehicle)
            park_core key, vehicle
            puts "*"*50
            puts "Your Vehicle is parked"
            puts "*"*50
            puts "Logger : #{parking_space.space}"
            parking_space.money_earned+=vehicle.cost_of_parking
        else
            puts "This space is already taken";
            puts "Kindly choose a new space";
            self.park_main vehicle
        end
    end

    def can_park?(key, vehicle)
        return_boolean = true
        array = key.split('_');
        floor = array[0].to_i
        row_min = (array[1].to_i) - 1
        row_max = row_min + ((vehicle.row_space.to_i) -1)
        column_min = (array[2].to_i) -1
        column_max =  column_min + ((vehicle.column_space.to_i) -1)
        #puts three_d_array
        if(self.parking_space.space.has_key? key)
            return false
        else
            for i in row_min..row_max
                for j in column_min..column_max
                    if parking_space.three_d_array[floor][i][j]!=nil
                        return false
                    end
                end
            end
        end
        return return_boolean
    end

    def get_vehicle_type(car_number)
        car_type = nil
        puts "Kindly choose the Vehicle Type from below option"
        puts "1) Car"
        puts "2) Bike"
        puts "3) Truck"
        car_type_option = get_int
        case car_type_option
        when 1
            car_type = Car.new(car_number)
        when 2
            car_type = Bike.new(car_number)
        when 3
            car_type = Truck.new(car_number)
        else
            puts "You have chosen the wrong option"
            car_type = get_vehicle_type car_number
        end
        return car_type
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
        if(space.has_key?(new_key) && space[new_key]!=car_number )
            puts "This parking space is already in use"
            return
        end
        vehicle = unpark_using_car_number_core car_number
        park_core new_key, vehicle
        puts "location changed successfully" 
    end

    def print_parking_space
        for k in 0..floor-1
            puts "*****************#{k} Floor***************"
            two_d_array1 = parking_space.three_d_array[k]
            for i in 0..rows-1
                for j in 0..columns-1
                    if(two_d_array1[i][j]==nil)
                        print("#{j+1}|            |")
                    else
                        print "#{j+1}|#{two_d_array1[i][j]}|"
                    end
                end
                puts ""
            end
        end
    end

    private

    def get_validated_car_number
        puts "Kindly enter your Vehicle number : (Format -> 'AA 12 A 1234')"
        car_number = gets.chomp
        if(car_number.match(/^[a-zA-Z]{2}\s\d{2,3}\s[a-zA-Z]{1,3}\s\d{4}$/))
            return car_number.upcase
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
        vehicle = nil
        while(parking_space.space.key(car_number)!=nil)
            key = parking_space.space.key(car_number)
            array = key.split('_')
            vehicle = parking_space.three_d_array[array[0].to_i][array[1].to_i][array[2].to_i]
            parking_space.three_d_array[array[0].to_i][array[1].to_i][array[2].to_i]=nil
            parking_space.space.delete(key)
        end
        return vehicle
    end

    def unpark_using_parking_address
        puts "You have chosen un-park using parking address"
        key = get_parking_address
        if(parking_space.space.has_key? key)
            car_number = parking_space.space[key]
            #space.delete(key)
            unpark_using_car_number_core car_number
            puts "Vehicle : #{car_number} has been unparked"
            puts "logger : #{parking_space.space}"
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
        puts "Enter Floor at which vehicle needs to be parked (Floors Allowed - 0..#{(parking_space.floor)-1})";
        floor_no = gets.chomp.to_i
        if (floor_no < 0 || floor_no >= parking_space.floor)
            puts "invalid floor number"
            return get_floor
        end
        return floor_no
    end

    def get_row_no
        puts "Enter Row at which vehicle needs to be parked (Rows Allowed - 1..#{parking_space.rows})";
        row_no = get_int
        if (row_no < 0 || row_no > parking_space.rows)
            puts "invalid row number"
            return get_row_no
        end
        return row_no
    end

    def get_column_no
        puts "Enter Column at which vehicle needs to be parked (Columns Allowed - 1..#{parking_space.columns})";
        column_no = get_int
        if (column_no < 0 || column_no > parking_space.columns)
            puts "invalid column number"
            return get_column_no
        end
        return column_no
    end

    def print_parking_address_from_key(key)
        array = key.split('_');
        puts "Floor : #{array[0]} Row : #{array[1]} Column : #{array[2]}"
    end

    def park_core(key, vehicle)
        array = key.split('_');
        floor = array[0].to_i
        row_min = (array[1].to_i) -1
        row_max = row_min + ((vehicle.row_space.to_i) -1)
        column_min = (array[2].to_i) -1
        column_max =  column_min + ((vehicle.column_space.to_i) -1)
        for i in row_min..row_max
            for j in column_min..column_max
                parking_space.three_d_array[floor][i][j]=vehicle
                parking_space.space["#{floor}_#{i}_#{j}"]=vehicle.vehicle_number
            end
        end
    end
end
