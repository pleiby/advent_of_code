# day2

#= Part 1
--- Day 2: Dive! ---
Now, you need to figure out how to pilot this thing.

It seems like the submarine can take a series of commands like forward 1, down 2, or up 3:

    forward X increases the horizontal position by X units.
    down X increases the depth by X units.
    up X decreases the depth by X units.

Calculate the horizontal position and depth you would have after following the planned course. 
What do you get if you multiply your final horizontal position by your final depth?
=#

using DataFrames
using CSV

# read space-delimited data into a DataFrame
course_df = CSV.read("2021/day2/input.txt", DataFrame, header=false, delim=' ')

combine(course_df, # rename columns
    :Column1 => :direction,
    :Column2 => :distance
)

# for DataFrame operations, see [Data Wrangling with DataFrames.jl]()
DataFrame(x = [1,2,3], y = 4:6, z = 9)
DataFrame("x" => [1,2], "y" => [3,4])
DataFrame(rand(5, 3), [:x, :y, :z])

head(course_df)

ispos(x) = (x>0)

# convert to integers
soundings = map(parse1Int, soundings)

# differences
Dsoundings = soundings[2:end] - soundings[1:(end-1)]

sum(map(ispos, Dsoundings)) # count positive changes

#= Part 2

=#

# Consider sums of a three-measurement sliding window.
# How many sums are larger than the previous sum?



