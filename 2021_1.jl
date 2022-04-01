increas_num_part1 = 0
increas_num_part2 = 0

###this function aim to calculate increase between succesive measurements as explained part 1
function part_1_increase(meas_couple)
    global increas_num_part1
    increas_num_part1 += meas_couple[1] < meas_couple[2]
end

###this function aim to calculate increase between succesive measurements as explained part 2
function part_2_increase(meas_couple)
    global increas_num_part2
    increas_num_part2 += meas_couple[1] < meas_couple[4]
end

function increase_calculator(measurements, func, window_size, step_size=1)
    #lets roll over measurements array 
    for meas_group in ((@view measurements[i:i+window_size]) for i in 1:step_size:length(measurements)-window_size)
        func(meas_group)
    end
end


function main()
    measurements = readlines("2021_1.txt")

    ###Connvert measurements to Int32
    measurements = map(x -> parse(Int, x), measurements)
    println("lenght of measurements: $(length(measurements))")

    increase_calculator(measurements, part_1_increase, 1)

    println("Answer of part 1:")
    println("num of increases:  $(increas_num_part1)")

    println("---")

    increase_calculator(measurements, part_2_increase, 3)

    println("Answer of part 2:")
    println("num of increases:  $(increas_num_part2)")

end

main()