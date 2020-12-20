# --- Day 5: Binary Boarding ---

"Decode the seat row."
function decode_row(row::AbstractString)
    left, right = 0, 127
    for i in row
        middle = (left + right) ÷ 2
        if i == 'F'
            right = middle
        else
            left = middle + 1
        end
    end
    return right
end

"Decode the seat column."
function decode_column(column::AbstractString)
    left, right = 0, 7
    for i in column
        middle = (left + right) ÷ 2
        if i == 'L'
            right = middle
        else
            left = middle + 1
        end
    end
    return right
end

"Return unique seat ID from boarding pass."
function seat_id(boardingpass::AbstractString)
    return decode_row(boardingpass[1:7]) * 8 + decode_column(boardingpass[8:end])
end

"Return results for day 5."
function day05(input_fn::AbstractString=joinpath(@__DIR__, "input.txt"))
    input = readlines(input_fn)
    ids = seat_id.(input)
    return maximum(ids), sum(collect(minimum(ids):maximum(ids))) - sum(ids)
end
