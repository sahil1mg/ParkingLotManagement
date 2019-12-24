class Vehicle
    attr_accessor :vehicle_number, :cost_of_parking, :row_space, :column_space
    def initialize(vehicle_number)
        @vehicle_number = vehicle_number.upcase
        @cost_of_parking = 30
    end

    def eqls?(other)
        self.vehicle_number = other.vehicle_number
    end

    def to_s
        self.vehicle_number
    end
end

class Car < Vehicle
    def initialize(vehicle_number)
        super
        @cost_of_parking=20
        @row_space=4
        @column_space=4
    end

end

class Bike < Vehicle
    def initialize(vehicle_number)
        super
        @cost_of_parking = 10
        @row_space=2
        @column_space=1
    end
end

class Truck < Vehicle
    def initialize(vehicle_number)
        super
        @cost_of_parking = 50
        @row_space=5
        @column_space=5
    end
end
