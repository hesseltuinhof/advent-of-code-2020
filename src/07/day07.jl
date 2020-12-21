# --- Day 7: Handy Haversacks ---

"Determine if a given outer bag contains at least one shiny gold inner bag."
function shiny_gold(outer::AbstractString, bags::Dict)
    if "shiny gold" ∈ bags[outer]
        return true
    elseif "no other" ∈ bags[outer]
        return false
    end
    for inner in bags[outer]
        shiny_gold(inner, bags) && return true
    end
    return false
end

"Count all outer bags that contain at least one shiny gold inner bag."
function count_shiny_gold(bags::Dict)
    cnt = 0
    for (outer, inner) in bags
        if shiny_gold(outer, bags)
            cnt +=1
        end
    end
    return cnt
end

"Parse rules and return as dictionary."
function rules(input_fn::Union{AbstractString, IO})
    r = r"\w+\s\w+(?=\sbag)"
    rules = eachmatch.(r, readlines(input_fn))
    bags = map.(rule -> rule.match, rules)
    return Dict(map(bag -> bag[1] => bag[2:end], bags))
end

"Return results for day 7."
function day07(input_fn::AbstractString=joinpath(@__DIR__, "input.txt"))
    bags = rules(input_fn)
    return count_shiny_gold(bags)
end
