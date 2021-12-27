# Source https://mdneuzerling.com/post/advent-of-code-2021-a-julia-journal-part-1/

import ShiftedArrays
import RollingFunctions

function part1(inputvector)
    @chain inputvector begin
        parse.(Int32, _)  # convert strings to integers
        _ .- ShiftedArrays.lag(_) # compute difference with previous value
        _[2:end] # remove first element, which will be missing
        filter(x -> x > 0, _) # filter to the increases in value
        length # now count
    end
end

input = readlines("2021/day01/input.txt")

p1 = part1(input)
println("Day01 pt1: $p1")

function part2(inputvector)
    @chain inputvector begin
        parse.(Int32, _)  # convert strings to integers
        _ .- ShiftedArrays.lag(_) # compute difference with previous value
        _[2:end] # remove first element, which will be missing
        RollingFunctions.rollmean(_, 3)# need to rolling sum or mean of 3 values
        filter(x -> x > 0, _) # filter to the increases in value
        length # now count
    end
end

p2 = part2(input)
println("Day01 pt2: $p2")

