f = open("src/Day_01/input.txt")
s = read(f, String)

# part 1
sl = split(s, "\n")
result = 0
for l in sl
    digits = []
    for c in l
        if isdigit(c)
            push!(digits, c)
        end
    end
    first_digit = first(digits)
    last_digit = last(digits)
    result = result + 10 * parse(Int, first_digit) + parse(Int, last_digit)
end
println(result)

# part 2
digits_words = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
for (index, word) in enumerate(digits_words)
    s = replace(s, string(index) => word)
end
sl = split(s, "\n")
result = 0
for l in sl
    firsts = []
    lasts = []
    for (index, word) in enumerate(digits_words)
        ind_first = findfirst(word, string(l))
        ind_last = findlast(word, string(l))
        if ind_first !== nothing
            push!(firsts, ind_first[1])
        else
            push!(firsts, Inf)
        end
        if ind_last !== nothing
            push!(lasts, ind_last[1])
        else
            push!(lasts, 0)
        end
    end
    val_first, first = findmin(firsts)
    val_last, last = findmax(lasts)
    new_result = 10 * first + last
    result = result + new_result
end
println(result)