using DataStructures
FILE_NAME = "2021_10.txt"

#')'- 1 = '('
#']'- 2 = '['
#'>'- 2 = '<'
#'}'- 2 = '{'

function end_finder(char::Char)
    if char == '('
        return ')'
    end
    return char + 2
end

function autocomplete(line::String)
    end_chars = Dict(')' => (3, 1), ']' => (57, 2), '}' => (1197, 3), '>' => (25137, 4))
    char_stack = Stack{Char}()
    total_ac_score::Int = 0

    for char in line
        if char in keys(end_chars)
            last_chunk_start = pop!(char_stack)
            if last_chunk_start + 2 != char && last_chunk_start + 1 != char
                return end_chars[char][1], 0
            end
        else
            push!(char_stack, char)
        end
    end

    #autocomplete part
    while length(char_stack) > 0
        current_char = pop!(char_stack)
        end_char = end_finder(current_char)
        total_ac_score *= 5
        total_ac_score += end_chars[end_char][2]
    end

    return 0, total_ac_score
end

function median_finder(data::Vector{Int})
    data_lenght = length(data)
    sorted_data = sort(data)
    median_index = convert(Int, ceil(data_lenght / 2))
    return sorted_data[median_index]
end

function main()
    lines = readlines(FILE_NAME)
    ac_scores = Vector{Int}()
    part1_res = 0
    part2_res = 0
    for line in lines
        err, ac = autocomplete(line)

        part1_res += err
        append!(ac_scores, [ac])

    end
    filter!(x -> x != 0, ac_scores)
    part2_res = median_finder(ac_scores)
    println("part1_res: $(part1_res)")
    println("part2_res: $(part2_res)")
end

main()