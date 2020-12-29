# --- Day 10: Adapter Array ---

"Count the 1-jolt and 3-jolt differences."
function distribution(ratings::AbstractArray{Int})
    sorted = vcat(0, sort(ratings))
    difference = sorted[2:end] - sorted[1:end-1]
    return count(isequal(1), difference), count(isequal(3), difference) + 1
end

"Count distinct adapter arrangements."
function distinct(ratings::AbstractArray{Int})
    sorted = vcat(0, sort(ratings))
    difference = sorted[2:end] - sorted[1:end-1]
    lengths = map(length, split(join(difference), "3"))
    return 2^count(isequal(2), lengths) * 4^count(isequal(3), lengths) * 7^count(isequal(4), lengths)
end

"Return results for day 10."
function day10(input_fn::AbstractString=joinpath(@__DIR__, "input.txt"))
    input = parse.(Int, readlines(input_fn))
    return distribution(input) |> prod, distinct(input)
end
