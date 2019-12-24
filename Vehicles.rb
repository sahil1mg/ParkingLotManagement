class Vehicle
    attr_accessor :vehicle_number, :cost_of_parking, :row_space, :column_space
    def initialize(vehicle_number)
        self.vehicle_number = vehicle_number.upcase
        self.cost_of_parking = 30
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
        self.cost_of_parking=20
        self.row_space=4
        self.column_space=4
    end
end

class Bike < Vehicle
    def initialize(vehicle_number)
        super
        self.cost_of_parking = 10
        self.row_space=2
        self.column_space=1
    end
end

class Truck < Vehicle
    def initialize(vehicle_number)
        super
        self.cost_of_parking = 50
        self.row_space=5
        self.column_space=5
    end
end