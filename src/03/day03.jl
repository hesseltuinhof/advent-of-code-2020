# --- Day 3: Toboggan Trajectory ---

"Count trees for a given slope pattern and geology map."
function count_trees(geology_map::Union{AbstractString, IO}, right::Int, down::Int)
    cnt, position = 0, 0
    for (i, level) in enumerate(eachline(geology_map))
        mod(i-1, down) != 0 && continue
        if level[mod(position, length(level))+1] == '#'
            cnt += 1
        end
        position += right
    end
    return cnt
end

"Return results for day 3."
function day03(input_fn::AbstractString=joinpath(@__DIR__, "input.txt"))
    right, down = [1, 3, 5, 7, 1], [1, 1, 1, 1, 2]
    return count_trees(input_fn, 3, 1), prod(count_trees.(input_fn, right, down))
end
