FILE_NAME = "2021_7.txt"



function position_counter(positions)
    counter_dict = Dict{Int,Int}()
    for position in positions
        if haskey(counter_dict, position)
            counter_dict[position] += 1
        else
            counter_dict[position] = 1
        end
    end

    return counter_dict
end


function calculate_cost(dict, minima)
    cost::Int = 0
    for (key, val) in dict
        cost += (abs(key - minima) * val)
    end
    return cost
end


function median_finder(data::Vector{Int})
    data_lenght = length(data)
    sorted_data = sort(data)
    median_index = convert(Int, round(data_lenght / 2))
    return sorted_data[median_index]
end

function cost_of_move(crab_pose, target_pose)
    #this function for part2
    diff = abs(crab_pose - target_pose)
    return sum(1:diff)
end

function part2_cost_of_opt(positions::Vector{Int})
    min_cost = Inf
    for index in 1:length(positions)
        total_cost = sum(map(x -> cost_of_move(x, index), positions))
        min_cost = min(min_cost, total_cost)
    end
    return min_cost
end


function main()
    line = readline(FILE_NAME)
    positions = map(x -> parse(Int, x), split(line, ','))

    median = median_finder(positions)
    position_counts = position_counter(positions)

    part2_res = part2_cost_of_opt(positions)

    part1_res = calculate_cost(position_counts, median)
    println("Part1 optimum position: $(median)")
    println("Part1 cost: $(part1_res)")
    println("---")
    println("Part2 cost: $(part2_res)")

end


main()