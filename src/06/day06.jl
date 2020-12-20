# --- Day 6: Custom Customs ---

"Identify questions for which anyone answered 'yes'."
function any_yes(group::AbstractString)
    return replace(group, "\n" => "") |> Set |> length
end

"Identify questions for which everyone answered 'yes'."
function every_yes(group::AbstractString)
    return intersect(split(group, '\n')...) |> length
end

"Return results for day 6."
function day06(input_fn::AbstractString=joinpath(@__DIR__, "input.txt"))
    input = split(readchomp(input_fn), "\n\n")
    return (any_yes.(input), every_yes.(input)) .|> sum
end
