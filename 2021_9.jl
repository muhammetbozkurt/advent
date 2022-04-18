FILE_NAME = "2021_9.txt"


function interpret_data(lines::Vector{String})
    return hcat(map(line -> map(x -> parse(Int, x), collect(line)), lines)...)
end



function collect_lowest_points(data::Matrix{Int64})
    X, Y = size(data)

    lowest_points = Vector{Int}()
    lowest_coors = Vector{Tuple{Int,Int}}()

    for i in 1:X
        for j in 1:Y
            current = data[i, j]
            up = i == 1 ? Inf : data[i-1, j]
            down = i == X ? Inf : data[i+1, j]
            left = j == 1 ? Inf : data[i, j-1]
            right = j == Y ? Inf : data[i, j+1]

            if current < up && current < down && current < left && current < right
                append!(lowest_points, [current])
                append!(lowest_coors, [(i, j)])
            end
        end
    end
    return lowest_points, lowest_coors
end

function calc_basin(x::Int, y::Int, info::Matrix{Int}, total_num::Int)
    X, Y = size(info)
    #limit of map
    if x < 1 || x > X || y < 1 || y > Y
        return total_num
    end

    if info[x, y] == 9 || info[x, y] == -1
        return total_num
    end
    total_num += 1
    info[x, y] = -1

    left = calc_basin(x, y - 1, info, 0)
    right = calc_basin(x, y + 1, info, 0)
    up = calc_basin(x - 1, y, info, 0)
    down = calc_basin(x + 1, y, info, 0)

    return total_num + left + right + up + down

end

function find_all_basins(data::Matrix{Int}, lowest_coors::Vector{Tuple{Int,Int}})
    info = copy(data)

    size_list = Vector{Int}()
    for coor in lowest_coors
        res = calc_basin(coor[1], coor[2], info, 0)
        if res != 0
            append!(size_list, [res])
        end
    end
    return size_list
end

function main()
    lines = readlines(FILE_NAME)
    data = interpret_data(lines)

    lowest_points, lowest_coors = collect_lowest_points(data)
    part1_res = sum(lowest_points) + length(lowest_points)

    res = find_all_basins(data, lowest_coors)
    sort!(res, rev=true)
    part2_res = prod(res[1:3])

    println("part 1 result: $(part1_res)")
    println("part 2 result: $(part2_res)")
end

main()