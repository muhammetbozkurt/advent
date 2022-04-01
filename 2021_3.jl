#gama_rate
#epsilon_rate
#power_consuption =gama_rate * epsilon_rate


#They are 5 bits number and epsilon = (gama)' so 31 - gama = epsilon


function count_ones_(lines::Vector{String})
    ones_counter::Vector{Int} = zeros(Int, length(lines[1]))
    println(ones_counter)

    for line in lines
        for i in 1:length(line)
            ones_counter[i] += (line[i] == '1')
        end
    end
    return ones_counter
end

function gama_epsilon_calculator(one_counts::Vector{Int}, total_num_lines::Int)
    limit::Int = 2^length(one_counts) - 1
    threshold = total_num_lines / 2
    binary_string::String = reduce((x, y) -> x * y, map(x -> x > threshold ? "1" : "0", one_counts))
    gama = parse(Int, binary_string; base=2)
    epsilon = limit - gama
    return gama, epsilon
end



## life support rating = O2 generator rate * CO2 scrubber rate

##filter bits according to bit criteria


function recursive(lines::Vector{String}, index::Int=1, most_comman_flag::Bool=true)
    len = length(lines)
    if len == 1
        return lines[1]
    end

    ones = filter(line -> line[index] == '1', lines)
    ones_size = length(ones)
    zeros_size = len - ones_size

    ### New index val
    new_index = (index % length(lines[1])) + 1
    if most_comman_flag
        if zeros_size <= ones_size
            return recursive(ones, new_index)
        end
        return recursive(filter(x -> x[index] == '0', lines), new_index)
    end

    if zeros_size <= ones_size
        return recursive(filter(x -> x[index] == '0', lines), new_index, false)
    end
    return recursive(ones, new_index, false)

end

function main()
    binaries = readlines("2021_3.txt")

    one_counts = count_ones_(binaries)
    gama, epsilon = gama_epsilon_calculator(one_counts, length(binaries))



    O2_rate = recursive(binaries, 1)
    CO2_rate = recursive(binaries, 1, false)

    O2_rate_int = parse(Int, O2_rate, base=2)
    CO2_rate_int = parse(Int, CO2_rate, base=2)

    println("gama rate: $(gama)")
    println("epsilon rate: $(epsilon)")
    println("Result $(gama* epsilon)")

    println("---")

    println("O2_rate binary: $(O2_rate)")
    println("CO2_rate binary: $(CO2_rate)")
    println("O2_rate 10 base: $(O2_rate_int)")
    println("CO2_rate 10 base: $(CO2_rate_int)")
    println("Result: $(O2_rate_int * CO2_rate_int)")
end

main()