FILE_NAME = "2021_8.txt"


function interpret_lines(lines::Vector{String})
    return map(row -> [split(row[1], ' '), split(row[2], ' ')], map(line -> split(line, " | "), lines))
end

function count_uniques(data)
    return length(reduce((x, y) -> vcat(x, y), map(row -> filter(digit -> length(digit) == 2 || length(digit) == 3 || length(digit) == 7 || length(digit) == 4, row[2]), data)))
end

function calc_diff(first, second)
    diff = 0
    for char in first
        if !occursin(char, second)
            diff += 1
        end
    end

    return diff
end

function is_equal(first, second)
    if length(first) != length(second)
        return false
    end
    return calc_diff(first, second) == 0
end

function detect_uniques(row, sorted_vector::Vector{String})
    sorted_vector[1] = filter(x -> length(x) == 2, row[1])[1]
    sorted_vector[4] = filter(x -> length(x) == 4, row[1])[1]
    sorted_vector[7] = filter(x -> length(x) == 3, row[1])[1]
    sorted_vector[8] = filter(x -> length(x) == 7, row[1])[1]
end

function detect_2_3(row, sorted_vector::Vector{String})
    two_three_five = filter(x -> length(x) == 5, row[1])
    #only "3" contains "1"
    for num in two_three_five
        if calc_diff(sorted_vector[1], num) == 0
            sorted_vector[3] = num
        elseif calc_diff(sorted_vector[4], num) == 1
            #diff of "4" and "5" is 1
            sorted_vector[5] = num
        else
            sorted_vector[2] = num
        end
    end
end

function detect_0_6_9(row, sorted_vector::Vector{String})
    zero_six_nine = filter(x -> length(x) == 6, row[1])
    for num in zero_six_nine
        if calc_diff(sorted_vector[4], num) == 0
            #only "9" contains "4"
            sorted_vector[9] = num
        elseif calc_diff(sorted_vector[7], num) == 0
            #"0" includes "7"
            sorted_vector[10] = num
        else
            sorted_vector[6] = num
        end
    end
end

function convert2int(digit, sorted_vector)
    for i in 1:9
        if is_equal(digit, sorted_vector[i])
            return i
        end
    end
    return 0
end

function decode_row(row)
    #initialize sorted vector (but "0" is 10th element)
    sorted_vector = ["-1" for _ in 1:10]
    detect_uniques(row, sorted_vector)
    detect_2_3(row, sorted_vector)
    detect_0_6_9(row, sorted_vector)

    decoded_num = 0
    for i in 1:4
        decoded_num += convert2int(row[2][i], sorted_vector) * 10^(4 - i)
    end

    return decoded_num
end


function main()
    lines = readlines(FILE_NAME)
    data = interpret_lines(lines)
    part1_res = count_uniques(data)
    part2_res = sum(map(row -> decode_row(row), data))

    println("part 1 result: $(part1_res)")
    println("part 2 result: $(part2_res)")

end

main()