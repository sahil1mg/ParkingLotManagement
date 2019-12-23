class Vehicles

attr_accessor :vehicle_number, :cost_of_parking

def initialize(vehicle_number, cost_of_parking)
    @vehicle_number = vehicle_number
    @cost_of_parking = cost_of_parking
end

def eqls?(other)
    self.vehicle_number = other.vehicle_number
end

end

class Car < Vehicles
    def initialize(vehicle_number)
        super(vehicle_number, 20)
    end
end

class Bike < Vehicles
    def initialize(vehicle_number)
        super(vehicle_number, 10)
    end
end

class Truck < Vehicles
    def initialize(vehicle_number)
        super(vehicle_number, 50)
    end
end
