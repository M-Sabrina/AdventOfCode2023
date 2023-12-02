### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ 5c1d20e0-e498-4127-a2f5-eee8a2e5661c
md"# Day 2 - Part 1"

# ╔═╡ d4187c1d-551f-4090-8e60-9507e3c0434a
s = read("input.txt", String)

# ╔═╡ 7ee6c5a1-4e3b-4bbb-a89e-6cfda1fd810f
sl = split(s, "\n")

# ╔═╡ 6a2c2806-207a-4f3e-ae93-bbe835dc0af3
max_rgb = [12, 13, 14]

# ╔═╡ 766fe260-803f-4013-8463-de4a85e86c7d
function count_cubes(sl)
	sum = 0
	for (id, line) in enumerate(sl)
		rgb = [0, 0, 0]
		results = split(line, ": ")[2]
		games = split(results, "; ")
		for game in games
			cubes = split(game, ", ")
			for cube in cubes
				if occursin("red", cube)
					index=1
				elseif occursin("green", cube)
					index=2
				else
					index=3
				end
				count = parse(Int, split(cube, " ")[1])
				if count > rgb[index]
					rgb[index] = count
				end
			end
		end
		if any(rgb .> max_rgb)
			valid = false
		else
			valid = true
		end
		if valid
			sum = sum + id
		end
	end
	return sum
end

# ╔═╡ 930ce723-84c3-45f6-ba7d-63d5cfe7528c
count_cubes(sl)

# ╔═╡ Cell order:
# ╟─5c1d20e0-e498-4127-a2f5-eee8a2e5661c
# ╠═d4187c1d-551f-4090-8e60-9507e3c0434a
# ╠═7ee6c5a1-4e3b-4bbb-a89e-6cfda1fd810f
# ╠═6a2c2806-207a-4f3e-ae93-bbe835dc0af3
# ╠═766fe260-803f-4013-8463-de4a85e86c7d
# ╠═930ce723-84c3-45f6-ba7d-63d5cfe7528c
