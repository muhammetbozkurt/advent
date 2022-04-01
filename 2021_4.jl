function read_data(file_name::String)

    list_of_carts = Vector()

    lines = readlines(file_name)

    ###first line is entries
    entries = map(x -> parse(Int, x), split(lines[1], ','))
    index = 2

    while length(lines) > index
        if lines[index] == ""
            index += 1
            continue
        end
        #get copy of
        cart = mapreduce(permutedims, vcat, map(line -> map(decimal -> parse(Int, decimal), split(line)), lines[index:index+4]))
        append!(list_of_carts, [cart])

        ### size of cart 5x5 so after reading cart we need to stride 5 lines
        index += 5

    end

    return entries, list_of_carts
end

function is_win(cart::Matrix{Int})
    ### if current cart won the game sum of a row or column of it is zero
    #because we use zero to mark entries
    for i in 1:length(cart[1, :])
        if sum(cart[i, :]) == 0 || sum(cart[:, i]) == 0
            return true
        end
    end
    return false
end

function get_score_of_winner(entries, list_of_carts)
    for entry in entries
        for cart in list_of_carts
            ### if entry point exist mark there with zero
            cart[cart.==entry] .= 0

            ### check if game current cart win the game
            win_flag = is_win(cart)

            if (win_flag)
                return entry * sum(cart)
            end
        end
    end
    return -1
end

function get_score_of_last_winner(entries::Vector{Int}, list_of_carts::Vector{Any})
    for entry in entries

        index = 1
        while index <= length(list_of_carts)
            ### if entry point exist mark there with zero
            list_of_carts[index][list_of_carts[index].==entry] .= 0

            ### check if game current list_of_carts[index] win the game
            win_flag = is_win(list_of_carts[index])

            if (win_flag)

                if length(list_of_carts) == 1
                    return entry * sum(list_of_carts[index])
                end
                deleteat!(list_of_carts, index)
                continue
            end

            index += 1
        end
    end
    return -1
end

function main()
    ### read data
    entries, list_of_carts = read_data("2021_4.txt")

    part1_res = get_score_of_winner(entries, list_of_carts)
    part2_res = get_score_of_last_winner(entries, list_of_carts)

    println("Result of part 1: $(part1_res)")
    println("Result of part 2: $(part2_res)")

end


main()