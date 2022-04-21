using DataStructures
FILE_NAME = "2021_10.txt"
end_chars = Dict(')' => 3, ']' => 57, '}' => 1197, '>' => 25137)

#')'- 1 = '('
#']'- 2 = '['
#'>'- 2 = '<'
#'}'- 2 = '{'


function illegal_calculator(line::String)
    char_stack = Stack{Char}()
    for char in line
        if char in keys(end_chars)
            last_chunk_start = pop!(char_stack)
            if last_chunk_start + 2 != char && last_chunk_start + 1 != char
                return end_chars[char]
            end
        else
            push!(char_stack, char)
        end

    end
    return 0
end

function main()
    lines = readlines(FILE_NAME)

    part1_res = 0
    for line in lines
        part1_res += illegal_calculator(line)
    end

    println("part1_res: $(part1_res)")
end

main()