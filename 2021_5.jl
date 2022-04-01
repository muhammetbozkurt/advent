FILE_NAME = "2021_5.txt"
DIAGRAM_SIZE = 1000

function line_2_points(point1::Vector{Int}, point2::Vector{Int}, diagonal_flag=false)
    ### this function returns indexes instead of (x,y) tuple 
    ### index = x * col_Size + y but there is adding and substracting 1 operations due to zero based vs one based arrays
    ### [a:b;b:a] is equal to [a:b] if b>a or is equal to [b:a] if a>b 
    if point1[1] == point2[1]
        return [(point1[1] - 1) * DIAGRAM_SIZE + i for i in [point1[2]:point2[2]; point2[2]:point1[2]]]
    elseif point1[2] == point2[2]
        return [(i - 1) * DIAGRAM_SIZE + point1[2] for i in [point1[1]:point2[1]; point2[1]:point1[1]]]
    elseif diagonal_flag
        #while finding points of diagonal line, order of points is matter
        is_greater = point1 .> point2
        cols = [point1[1]:point2[1]; point2[1]:point1[1]]
        cols = is_greater[1] ? cols : reverse(cols)
        cols .-= 1 #this operation is to convert (x,y) to index 

        rows = [point1[2]:point2[2]; point2[2]:point1[2]]
        rows = is_greater[2] ? rows : reverse(rows)

        return cols .* DIAGRAM_SIZE .+ rows

    end
    return []
end

function draw_lines(lines::Vector{String}, diagram::Matrix{Int}, diagonal_flag::Bool=false)

    for line in lines
        ### Extracting points
        point1, point2 = split(line, " -> ")
        point1 = map(x -> parse(Int, x) + 1, split(point1, ','))
        point2 = map(x -> parse(Int, x) + 1, split(point2, ','))

        ### getting indexes of line points
        indexes = line_2_points(point1, point2, diagonal_flag)
        ### adding them into diagram
        diagram[indexes] .+= 1
    end
end

function main()
    lines = readlines(FILE_NAME)
    diagram = zeros(Int, DIAGRAM_SIZE, DIAGRAM_SIZE)

    draw_lines(lines, diagram)
    part1_result = length(filter(x -> x >= 2, diagram))

    diagram = zeros(Int, DIAGRAM_SIZE, DIAGRAM_SIZE)
    draw_lines(lines, diagram, true)
    part2_result = length(filter(x -> x >= 2, diagram))

    println("part1 result: $(part1_result)")
    println("part2 result: $(part2_result)")
end

main()