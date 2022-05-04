FILE_NAME = "2021_14.txt"

function interpret_data(lines::Vector{String})
    decode_dict = Dict{String,Char}()
    for (x, y) in map(line -> split(line, " -> "), lines[3:length(lines)])
        decode_dict[x] = y[1]
    end

    polymer_dict = Dict{String,Int}(key => 0 for key in keys(decode_dict))

    for i in 1:length(lines[1])-1
        polymer_dict[lines[1][i:i+1]] += 1
    end

    return polymer_dict, decode_dict
end

function pol_convert(code::String, dict::Dict{String,Char})
    return "$(code[1])$(dict[code])", "$(dict[code])$(code[2])"
end


function count_chars(polymer_dict::Dict{String,Int})
    counter = Dict{Char,Int}(char => 0 for char in Set(string(keys(polymer_dict)...)))
    for key in keys(polymer_dict)
        num::Int = polymer_dict[key]
        counter[key[1]] += floor(UInt, num)
        counter[key[2]] += floor(UInt, num)
    end

    for key in keys(counter)
        #first and last char in polymer string is counted 1 less than others
        #e.g. other = 2 * (other_occurances) but first = 2 * (first_occurances) - 1
        counter[key] = ceil(Int, counter[key] / 2)
    end

    return counter
end


function step(polymer_dict::Dict{String,Int}, decode_dict::Dict{String,Char})
    new_dict = Dict{String,Int}(key => 0 for key in keys(decode_dict))
    for key in keys(polymer_dict)
        num::Int = polymer_dict[key]

        new_pol1, new_pol2 = pol_convert(key, decode_dict)
        new_dict[new_pol1] += num
        new_dict[new_pol2] += num

    end

    return new_dict
end


function diff_of_max_min(polymer_dict::Dict{String,Int})
    counter = count_chars(polymer_dict)

    least = min(values(counter)...)
    most = max(values(counter)...)
    return most - least
end

function main()
    lines = readlines(FILE_NAME)
    polymer_dict, decode_dict = interpret_data(lines)

    for i in 1:40
        polymer_dict = step(polymer_dict, decode_dict)
        if i == 10
            println("Answer of part1: $(diff_of_max_min(polymer_dict))")
        end
    end

    println("Answer of part2: $(diff_of_max_min(polymer_dict))")

end

main()