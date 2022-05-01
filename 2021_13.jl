function interpret_data(lines::Vector{String})
    coors = lines[contains.(lines, ',')]
    folds = lines[contains.(lines, "fold")]

    #Convert everything from 0 based to 1 based
    folds = map(row -> [Int(row[1][length(row[1])] - 'x' + 1), parse(Int, row[2]) + 1], map(x -> split(x, '='), folds))
    coors = map(x -> [parse(Int, x[1]) + 1, parse(Int, x[2]) + 1], map(x -> split(x, ','), coors))

    return coors, folds
end


function find_sym(point::Vector{Int}, axis::Int, fold::Int)

    res = Vector{Int}(point)

    res[axis] = point[axis] < fold ? point[axis] : 2 * fold - point[axis]

    return res
end


function main()

    lines = readlines("2021_13.txt")
    points, folds = interpret_data(lines)

    flag::Bool = true

    for fold in folds
        points = map(point -> find_sym(point, fold...), points)
        points = filter(point -> point[fold[1]] != fold[2], points)
        if flag
            println("Answer of part1: $(length(Set(points)))")
            flag = false
        end
    end

    println("Answer of part2: ")
    for j in 1:6
        for i in 1:40
            if [i, j] in points
                print('#')
            else
                print('.')
            end
        end
        println()
    end

end


main()