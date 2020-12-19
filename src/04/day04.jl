# --- Day 4: Passport Processing ---

"Parse a passport batch and return as dictionaries."
function parse_passport(batch::Union{AbstractString, IOBuffer})
    return map(split(readchomp(batch), "\n\n")) do s
        Dict(split.(split(s, (' ', '\n')), ':'))
    end
end

"Validate required passport fields."
function validate_passport_keys(passport::Dict)
    required = ["hcl", "ecl", "pid", "iyr", "eyr", "hgt", "byr"]
    return required ⊆ keys(passport)
end

"Validate required passport fields and values."
function validate_passport_values(passport::Dict)
    validate_passport_keys(passport) || return false
    1920 <= parse(Int, passport["byr"]) <= 2002 || return false
    2010 <= parse(Int, passport["iyr"]) <= 2020 || return false
    2020 <= parse(Int, passport["eyr"]) <= 2030 || return false
    if last(passport["hgt"], 2) == "cm"
        150 <= parse(Int, passport["hgt"][1:end-2]) <= 193 || return false
    elseif last(passport["hgt"], 2) == "in"
        59 <= parse(Int, passport["hgt"][1:end-2]) <= 76 || return false
    else
        return false
    end
    contains(passport["hcl"], r"^#[a-fA-F0-9]{6}$") || return false
    passport["ecl"] ∈ ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"] || return false
    contains(passport["pid"], r"^\d{9}$") || return false
    return true
end

"Return results for day 4."
function day04(input_fn::AbstractString=joinpath(@__DIR__, "input.txt"))
    input = parse_passport(input_fn)
    return count(validate_passport_keys.(input)), count(validate_passport_values.(input))
end
