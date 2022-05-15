

function get_min_dist(distance_dict::Dict, seen::Set)
    min_key = (-1, -1)
    min_val = Inf

    for (key, value) in distance_dict
        flag = min_val > value && !(key in seen)
        min_key = flag ? key : min_key
        min_val = flag ? value : min_val
    end

    return min_key
end

# function get_adjacent(pos, X, Y)
#     res = Vector{Tuple}()
#     for i in -1:2:1
#         for j in -1:2:1
#             x, y = pos .+ (i, j)
#             if 0 < x < X && 0 < y < Y
#                 push!(res, (x, y))
#             end
#         end
#     end
#     return res
# end

function get_adjacent(pos, X, Y)
    res = Vector{Tuple}()

    push!(res, pos .+ (0, -1))
    push!(res, pos .+ (0, 1))
    push!(res, pos .+ (1, 0))
    push!(res, pos .+ (-1, 0))

    return filter(x -> 0 < x[1] <= X && 0 < x[2] <= Y, res)
end

function dijkstra(cave_map::Matrix)
    distance_dict = Dict{Tuple,Int}()
    seen_set = Set{Tuple}()
    X, Y = size(cave_map)

    distance_dict[(1, 1)] = 0

    for _ in 1:length(cave_map)
        current = get_min_dist(distance_dict, seen_set)
        if current == (-1, -1)
            return distance_dict
        end
        push!(seen_set, current)

        children = get_adjacent(current, X, Y)
        for child in children
            adjencent_total_risk = haskey(distance_dict, child) ? distance_dict[child] : Inf
            if !(child in seen_set) && distance_dict[current] + cave_map[child...] < adjencent_total_risk
                distance_dict[child] = distance_dict[current] + cave_map[child...]
            end

        end

    end
    return distance_dict

end


function main()
    lines = readlines("2021_15.txt")
    cave_map = hcat(map(line -> map(x -> parse(Int, x), collect(line)), lines)...)

    res = dijkstra(cave_map)

    target = size(cave_map)

    println("result of part1: $(res[target...])")
end

main()