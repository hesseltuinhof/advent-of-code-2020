# --- Day 8: Handheld Halting ---

"Parse boot code and return operation and argument list."
function parse_bootcode(boot::Union{AbstractString, IOBuffer})
    return split.(readlines(boot))
end

"Execute boot code once and return accumulator value."
function accumulator(boot)
    value, idx, unvisited = 0, 1, fill(true, length(boot))
    while idx <= length(boot) && unvisited[idx]
        unvisited[idx] = false
        if boot[idx][1] == "nop"
            idx +=1
        elseif boot[idx][1] == "acc"
            value += parse(Int, boot[idx][2])
            idx +=1
        else
            idx += parse(Int, boot[idx][2])
        end
    end
    return value, idx > length(boot)
end

"Repair boot code by replacing 'jmp' and 'nop' operations and return accumulator value."
function repair(boot)
    for (idx, (operation, argument)) in enumerate(boot)
        if operation == "nop"
            boot[idx][1] = "jmp"
        elseif operation == "jmp"
            boot[idx][1] = "nop"
        else
            continue
        end
        value, terminated = accumulator(boot)
        boot[idx][1] = operation
        terminated && return value
    end
end

"Return results for day 8."
function day08(input_fn::AbstractString=joinpath(@__DIR__, "input.txt"))
    input = parse_bootcode(input_fn)
    return first(accumulator(input)), repair(input)
end
