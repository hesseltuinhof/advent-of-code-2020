# --- Day 1: Report Repair ---

"Find the unique pair of values whose sum equals 2020 and return their product."
function find_two_entries(seq::Vector{<:Number})
    sort!(seq)
    n, N = 1, length(seq)
    while seq[n] + seq[N] != 2020
        if seq[n] + seq[N] > 2020
            N -= 1
        else
            n += 1
        end
    end
    return seq[n] * seq[N]
end


"Find the unique triple of values whose sum equals 2020 and return their product."
@views function find_three_entries(seq::Vector{<:Number})
    for (i, value_i) in enumerate(seq)
        for (j, value_j) in enumerate(seq[i+1:end])
            value_i + value_j > 2020 && continue
            for (k, value_k) in enumerate(seq[j+1:end])
                value_i + value_j + value_k == 2020 && return value_i * value_j * value_k
            end
        end
    end
end

"Return results for day 1."
function day01(input_fn::AbstractString=joinpath(@__DIR__, "input.txt"))
    input = parse.(Int, split(read(input_fn, String)))
    return find_two_entries(input), find_three_entries(input)
end
