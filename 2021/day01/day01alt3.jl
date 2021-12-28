# source: https://github.com/Moelf/AoC2021/blob/main/day1.jl
# Also see thread on zulip that contains this and other solutions:
#   https://julialang.zulipchat.com/#streams/307139/advent-of-code.20.282021.29

const ints = parse.(Int, readlines("2021/day01/input.txt"))

p1 = count(>(0), diff(ints)) # interesting that >(0) is single var fn

println("Day01 pt1: $p1")

p2 = count(4:lastindex(ints)) do idx
    # clever obs that 1st diff of 3-term rolling sum is same as diff w/ 3rd lag
    ints[idx-3] < ints[idx]
end

println("Day01 pt2: $p2")


# Why does the x - x[-3] have same sign as the first diff of 3-period rolling sum?
using RollingFunctions, ShiftedArrays

r3_tmp = RollingFunctions.rolling(sum,
           ints, 
           3)
l3_tmp = ShiftedArrays.lag(ints, 3)

length(r3_tmp)
length(l3_tmp)

(ints - l3_tmp)[end-10:end]
(diff(r3_tmp))[end-10:end]
