### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ b052814e-11f8-47c8-8723-6a2fb6cbd7a9
s = read("input.txt", String)

# ╔═╡ 6c5c8d4e-8161-435d-b4b8-03d4f8764700
sl = split(s, "\n")

# ╔═╡ 46ae9c37-c6a3-4b80-85ef-c145bf56ae29
function str2char(a::Vector{SubString{String}})::Matrix{Char}
    n = length(a[1])
    A = Matrix{Char}(undef,n,n) # preallocating the result
    for i in 1:length(a) # looping over all strings
        for (j, c) in enumerate(a[i]) # looping over all chars in a string
            A[i, j] = c
        end
    end
    return A
end
# thanks goes to: https://discourse.julialang.org/t/converting-a-array-of-strings-to-an-array-of-char/35123/2

# ╔═╡ db1bf3fc-e190-4ef5-843a-f65bf5966538
sa = str2char(sl)

# ╔═╡ 6eed9ac2-91bf-11ee-03e3-516651cd1f66
md"# Day 3 - Part 1"

# ╔═╡ cb2d5a42-d307-4908-b352-9ef0d6698148
function locate(sa::Matrix{Char})::Matrix{Int}
	m = zeros(Int, size(sa))
	for (i, c) in enumerate(sa)
		if isdigit(c)
			m[i] = 1
		elseif c != '.'
			m[i] = 2
		end
	end
	return m
end

# ╔═╡ a8dcb47e-cb12-4a9e-b63b-b3453d1b574f
m = locate(sa)

# ╔═╡ 89e3035a-8eb2-4a72-a457-9697f242ddbd
ym, xm = size(m)

# ╔═╡ 8fd55703-d7ba-42df-a679-831853140c24
begin
	mpad = zeros(Int, (ym+2, xm+2))
	mpad[2:ym+1,2:xm+1] = m
	nothing
end

# ╔═╡ f6b66b78-dc49-4d91-a2ef-0471d697c034
mpad

# ╔═╡ 2fd1ca46-1e13-4bb7-8808-0810bdf87d77
function adjacent(mpad::Matrix{Int})::Matrix{Int}
	keep = zeros(Int, (ym+2, xm+2))
	for x in 2:xm+1
		for y in 2:ym+1
			if mpad[y, x] == 1
				for xr in x-1:x+1
					for yr in y-1:y+1
						if yr==y && xr==x
							continue
						end
						if mpad[yr, xr] == 2
							keep[y, x] = 1
						end
					end
				end
			end
		end
	end
	return keep
end

# ╔═╡ b8eb51a9-937c-44b8-8124-ce153bc0d73d
keep = adjacent(mpad)

# ╔═╡ 2e21f545-1cc3-458f-ad3b-67c640764bf4
function mark(mpad::Matrix{Int}, keep::Matrix{Int})::Matrix{Bool}
	mmark = zeros(Bool, (ym, xm))
	mkeep = copy(keep)
	for i in 1:10 # assume that numbers only have up to 10 digits!
		for y in 1:ym
			for x in 1:xm
				if mpad[y+1, x+1] == 1
					for xr in x-1:x+1
						if mkeep[y+1, xr+1] == 1
							mmark[y, x] = true
							mkeep[y+1, x+1] = 1
						end
					end
				end
			end
		end
	end
	return mmark
end

# ╔═╡ c15768da-3858-43a4-a88e-95a538de8c3a
mmark = mark(mpad, keep)

# ╔═╡ 17bb8548-a0c8-4107-9bec-97e22aca595c
function get_total(sa::Matrix{Char}, mmark::Matrix{Bool}, ym::Int, xm::Int)::Int
	total = 0
	num = ""
	for y in 1:ym
		if !isempty(num)
			total += parse(Int, num)
		end
		num = ""
		for x in 1:xm
			value = sa[y, x]
			valid = mmark[y, x]
			if valid
				num = string(num, value)
			else
				if !isempty(num)
					total += parse(Int, num)
				end
				num = ""
			end
		end
	end
	total
end

# ╔═╡ 6600432c-4c59-4c26-8ebd-aaa2e36adc6d
get_total(sa, mmark, ym, xm)

# ╔═╡ 6f9daccd-c82c-443f-bdd6-76340e6e9607
md"# Day 3 - Part 2"

# ╔═╡ 8cef866b-ecc1-46c1-9911-1a87267245c3


# ╔═╡ Cell order:
# ╠═b052814e-11f8-47c8-8723-6a2fb6cbd7a9
# ╠═6c5c8d4e-8161-435d-b4b8-03d4f8764700
# ╠═46ae9c37-c6a3-4b80-85ef-c145bf56ae29
# ╠═db1bf3fc-e190-4ef5-843a-f65bf5966538
# ╟─6eed9ac2-91bf-11ee-03e3-516651cd1f66
# ╠═cb2d5a42-d307-4908-b352-9ef0d6698148
# ╠═a8dcb47e-cb12-4a9e-b63b-b3453d1b574f
# ╠═89e3035a-8eb2-4a72-a457-9697f242ddbd
# ╠═8fd55703-d7ba-42df-a679-831853140c24
# ╠═f6b66b78-dc49-4d91-a2ef-0471d697c034
# ╠═2fd1ca46-1e13-4bb7-8808-0810bdf87d77
# ╠═b8eb51a9-937c-44b8-8124-ce153bc0d73d
# ╠═2e21f545-1cc3-458f-ad3b-67c640764bf4
# ╠═c15768da-3858-43a4-a88e-95a538de8c3a
# ╠═17bb8548-a0c8-4107-9bec-97e22aca595c
# ╠═6600432c-4c59-4c26-8ebd-aaa2e36adc6d
# ╠═6f9daccd-c82c-443f-bdd6-76340e6e9607
# ╠═8cef866b-ecc1-46c1-9911-1a87267245c3
