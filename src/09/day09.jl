# --- Day 9: Encoding Error ---

"Parse encoding."
function parse_encoding(encoding::Union{AbstractString, IOBuffer})
    return parse.(Int, readlines(encoding))
end

"Validate that next number is sum of two previous numbers."
function validate_encoding(next::Int, previous::AbstractArray{Int})
    return any(next .- previous .∈ (previous,))
end

"Find first number that is not sum of two previous numbers."
function weakness(sequence::AbstractArray{Int}, preamble_length::Int=25)
    idx = preamble_length + 1
    while validate_encoding(sequence[idx], sequence[idx-preamble_length:idx-1])
        idx += 1
    end
    return sequence[idx]
end

"Find contiguous subsequence whose sum equals the weakness."
function contiguous(sequence::AbstractArray{Int}, weakness::Int)
    start, idx, sequence_copy = 0, nothing, copy(sequence)
    while idx == nothing
        @views sequence_copy[2+start:end] += sequence[1:end-1-start]
        start, idx = start + 1, findfirst(isequal(weakness), sequence_copy)
    end
    return sequence[idx-start:idx]
end

"Return results for day 9."
function day09(input_fn::AbstractString=joinpath(@__DIR__, "input.txt"))
    input = parse_encoding(input_fn)
    return weakness(input), contiguous(input, weakness(input)) |> extrema |> sum
end
