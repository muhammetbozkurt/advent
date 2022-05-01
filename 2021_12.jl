using DataStructures


mutable struct Cave
    name::String
    children::Vector{Cave}

    function Cave(name::String)
        new(name, Vector{Cave}())
    end

    function Cave(name::String, children::Vector{Cave})
        new(name, children)
    end

end

function get_cave_from_graph(name::String, graph::Dict{String,Cave})
    if !haskey(graph, name)
        graph[name] = Cave(name)
    end

    return graph[name]
end

function interpret_data(lines::Vector{String})
    graph = Dict{String,Cave}()

    for line in lines
        parent, child = split(line, '-')
        parent_cave::Cave = get_cave_from_graph(String(parent), graph)
        child_cave::Cave = get_cave_from_graph(String(child), graph)

        if parent_cave.name != "end" && child_cave.name != "start"
            add_child(parent_cave, child_cave)
        end
        if parent_cave.name != "start" && child_cave.name != "end"
            add_child(child_cave, parent_cave)
        end
    end

    return graph
end

function get_possible_ways(current::Cave, visited::Vector{Cave}, twice_allowance::Bool=false)
    twice_allowance = !(current in visited && lowercase(current.name) == current.name) && twice_allowance
    res = Vector{Cave}()
    for child in current.children
        if lowercase(child.name) != child.name
            push!(res, child)
        elseif !(child in visited) || twice_allowance
            push!(res, child)
        end
    end

    return res, twice_allowance
end

function add_child(parent::Cave, child::Cave)
    append!(parent.children, [child])
end


function dfs(current::Cave, visited::Vector{Cave}, twice_allowance::Bool=false)
    total_path_num::Int = 0
    new_visited = [visited..., current]

    ways, twice_allowance = get_possible_ways(current, visited, twice_allowance)
    if length(ways) == 0
        return current.name == "end"
    end


    for child in ways
        total_path_num += dfs(child, new_visited, twice_allowance)
    end

    return total_path_num

end




function main()
    lines = readlines("2021_12.txt")
    graph = interpret_data(lines)

    part1_res = dfs(graph["start"], Vector{Cave}())
    part2_res = dfs(graph["start"], Vector{Cave}(), true)

    println("part1: visiting small caves at most once and big caves unlimited")
    println("part1 result: $(part1_res)")
    println("---")
    println("part2: visiting one of the small caves twice, other small caves at most once and big caves unlimited")
    println("part2 result: $(part2_res)")
end


main()

















# start,b,A,c,A,b,A,end
# start,b,A,c,A,b,end
# start,b,A,c,A,c,A,end







