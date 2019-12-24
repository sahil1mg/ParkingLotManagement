def get_int                                                                                                                                 
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