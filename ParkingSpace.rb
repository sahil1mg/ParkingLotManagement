require "./Vehicles.rb"
require "./CommonFunc.rb"
class ParkingSpace
    attr_accessor :floor, :rows, :columns, :space, :money_earned, :three_d_array

    def initialize(floor, rows, columns)
        @floor = floor
        @rows = rows
        @columns = columns
        @space = Hash.new
        @money_earned=0
        @three_d_array = Array.new(floor)
        for i in 0..floor-1
            three_d_array[i]=Array.new(rows)
            for j in 0..rows-1
                three_d_array[i][j]=Array.new(columns)
            end
        end
    end

    def floor
        @floor
    end

    def columns
        @columns
    end

    def rows
        @rows
    end

    def space
        @space
    end

    def money_earned
        @money_earned
    end
end
