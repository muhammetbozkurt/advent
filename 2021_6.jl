FILE_NAME = "2021_6.txt"
PART_1_TOTAL_LIFETIME = 80
PART_2_TOTAL_LIFETIME = 256


function get_initial_bucket()
    line = readline(FILE_NAME)
    fish_list = map(x -> parse(Int8, x), split(line, ','))

    ### first index represent num of fishes whose timer is 0. 9th index represent num of fishes whose timer is 8 
    return [length(filter(x -> x == i, fish_list)) for i in 0:8]
end

function life_cycle(lifetime_bucket::Vector{Int}, general_timer::Int)
    ### Base statements
    if general_timer == 0
        return sum(lifetime_bucket)
    end

    ### Get number of new born fishes
    num_reset::Int = lifetime_bucket[1]

    ### Day passed
    new_bucket = circshift(lifetime_bucket, -1)
    #num of new borns and fishes reseting their lifetime are equal 
    new_bucket[7] += num_reset
    general_timer -= 1

    return life_cycle(new_bucket, general_timer)
end


function main()

    initial_bucket = get_initial_bucket()

    ###part1 life_cycle
    part1_res = life_cycle(lifetime_bucket, PART_1_TOTAL_LIFETIME)
    ###part2 life_cycle
    part2_res = life_cycle(lifetime_bucket, PART_2_TOTAL_LIFETIME)

    println("Result of part1: $(part1_res)")
    println("---")
    println("Result of part2: $(part2_res)")
end

main()