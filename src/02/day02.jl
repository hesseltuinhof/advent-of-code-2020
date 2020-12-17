# --- Day 2: Password Philosophy ---

"A `PasswordPolicySled` is defined by a unique character and a frequency range."
struct PasswordPolicySled
    character::String
    frequency_min::Int
    frequency_max::Int
end

"Construct a new `PasswordPolicySled` object from a password policy."
function PasswordPolicySled(policy::AbstractString)
    frequency_min, frequency_max, character = split(policy, ('-', ' '))
    PasswordPolicySled(character, parse(Int, frequency_min), parse(Int, frequency_max))
end

"A `PasswordPolicyToboggan` is defined by a unique character and two special positions."
struct PasswordPolicyToboggan
    character::String
    position_first::Int
    position_last::Int
end

"Construct a new `PasswordPolicyToboggan` object from a password policy."
function PasswordPolicyToboggan(policy::AbstractString)
    position_first, position_last, character = split(policy, ('-', ' '))
    PasswordPolicyToboggan(character, parse(Int, position_first), parse(Int, position_last))
end


"Validate the password against the password policy."
function validate_password((policy, password)::Tuple{PasswordPolicySled,AbstractString})
    validation = Regex("$(policy.character)")
    matches = collect(eachmatch(validation, password))
    return policy.frequency_min <= length(matches) <= policy.frequency_max
end

function validate_password((policy, password)::Tuple{PasswordPolicyToboggan,AbstractString})
    p_char, p_first, p_last = policy.character, policy.position_first, policy.position_last
    validation = Regex("^(?(?=.{$(p_first-1)}$(p_char))(.{$(p_last-1)}[^$(p_char)])|(.{$(p_last-1)}$(p_char)))")
    return contains(password, validation)
end

"Return results for day 2."
function day02(input_fn::AbstractString=joinpath(@__DIR__, "input.txt"))
    input = split.(readlines(input_fn), ": ")
    input_sled = map(row -> (PasswordPolicySled(row[1]), row[2]), input)
    input_toboggan = map(row -> (PasswordPolicyToboggan(row[1]), row[2]), input)
    return count(validate_password, input_sled), count(validate_password, input_toboggan)
end
