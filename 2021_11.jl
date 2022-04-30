FILE_NAME = "2021_11.txt"

function interpret_data(lines::Vector{String})
    return hcat(map(line -> map(x -> parse(Int, x), collect(line)), lines)...)
end

lines = readlines(FILE_NAME)
data = interpret_data(lines)

function flush_increase(data::Matrix{Int}, x::Int, y::Int)

    X::Int, Y::Int = size(data)
    left::Int = max(1, x - 1)
    right::Int = min(X, x + 1)

    up::Int = max(1, y - 1)
    bottom::Int = min(Y, y + 1)

    data[left:right, up:bottom] .+= 1
    data[x, y] -= 1
end

function flush_them_all(data::Matrix{Int}, flush_counter::Int)

    if length(data[data.>9]) == 0
        return flush_counter
    end

    X, Y = size(data)

    for x in 1:X
        for y in 1:Y
            if data[x, y] > 9
                flush_increase(data, x, y)
                data[x, y] = -99999
                flush_counter += 1
            end
        end
    end
    return flush_them_all(data, flush_counter)

end

function step(data::Matrix{Int})
    data .+= 1
    total_flush::Int = flush_them_all(data, 0)
    data[data.<0] .= 0

    return total_flush
end

function main()
    total_flushes::Int = 0
    first_step_all_flush::Int = -1

    lines = readlines(FILE_NAME)
    data = interpret_data(lines)

    X, Y = size(data)
    data_size = X * Y

    step_index::Int = 1

    while true
        flush_num_in_step = step(data)
        first_step_all_flush = (first_step_all_flush == -1 && data_size == flush_num_in_step) ? step_index : first_step_all_flush

        if step_index <= 100
            total_flushes += flush_num_in_step
        end

        #After find all answer 
        if step_index > 100 && first_step_all_flush != -1
            break
        end

        step_index += 1
    end
    println("total_flushes after 100 steps: $(total_flushes)")
    println("first step all of them flush: $(first_step_all_flush)")
end

main()