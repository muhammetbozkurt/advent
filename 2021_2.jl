

function interpret_command(cmd)
    orientation, value = split(cmd)
    value = parse(Int, value)
    if ("forward" == orientation)
        return [value, 0]
    elseif ("up" == orientation)
        return [0, -1 * value]
    end
    return [0, value]
end


function part2(commands)
    aim::Int = 0
    position::Vector{Int} = [0, 0]
    for i in 1:length(commands)
        horizontal_move::Int = commands[i][1]
        vertical_move::Int = commands[i][2]
        if vertical_move != 0
            aim += vertical_move
        else
            position[1] += horizontal_move
            position[2] += aim * horizontal_move
        end
    end
    return position
end



function main()
    commands = readlines("2021_2.txt")
    interpreted_cmds = map(interpret_command, commands)

    position = reduce((x, y) -> x + y, interpreted_cmds)
    part_1_result = position[1] * position[2]

    println("part 1 position: $(position)")
    println("part 1 result: $(part_1_result)")

    println("---")

    position = part2(interpreted_cmds)
    part_2_result = position[1] * position[2]

    println("part 2 position: $(position)")
    println("part 2 result: $(part_2_result)")
end

main()