# day1

#= Part 1

=#

using DataFrames

soundings = readlines("2021/day1/input.txt")

parse1Int(x) = parse(Int64, x)
ispos(x) = (x>0)

# convert to integers
soundings = map(parse1Int, soundings)

# differences
Dsoundings = soundings[2:end] - soundings[1:(end-1)]

sum(map(ispos, Dsoundings)) # count positive changes

#= Part 2
Start by comparing the first and second three-measurement windows.
The measurements in the first window are marked A (199, 200, 208); 
their sum is 199 + 200 + 208 = 607. 
The second window is marked B (200, 208, 210); its sum is 618. 
The sum of measurements in the second window is larger than the 
sum of the first, so this first comparison increased.

Your goal now is to count the number of times the sum of measurements 
in this sliding window increases from the previous sum. So, compare A 
with B, then compare B with C, then C with D, and so on. 
Stop when there aren't enough measurements left to create a new 
three-measurement sum.
=#

# Consider sums of a three-measurement sliding window.
# How many sums are larger than the previous sum?



function slidingsum(xvec, sumlength)
    xs = []
    for i in 1:(length(xvec) - sumlength + 1) # watch end condition
        currsum = 0
        for j in 0:(sumlength-1)
            currsum += xvec[i+j]
        end
        xs = push!(xs, currsum)
    end
    return(xs)
end

soundings_ss = slidingsum(soundings, 3) # 3-wide sliding sum

Dsoundings_ss = soundings_ss[2:end] - soundings_ss[1:(end-1)]

sum(map(ispos, Dsoundings_ss)) # count positive changes in sliding sum
