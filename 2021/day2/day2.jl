# day2 >https://adventofcode.com/2021/day/2>

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

using DataFrame
using CSV

# read space-delimited data into a DataFrame
course_df = CSV.read("2021/day2/input.txt", DataFrame, header=false, delim=' ')

combine(course_df, # rename columns (combine usuall applies to grouped df)
    :Column1 => :direction,
    :Column2 => :distance
)

course_df = select(course_df, # rename columns (select preserves all rows)
    :Column1 => :direction,
    :Column2 => :distance
)

function navigate_df(df)
    hpos, depth = 0, 0

    for i in 1:(size(df)[1])
        if df[i,:direction] == "forward" 
            hpos += df[i,:distance]
        elseif df[i,:direction] == "reverse"
            hpos -= df[i,:distance]
        elseif df[i,:direction] == "down"
            depth += df[i,:distance]
        elseif df[i,:direction] == "up"
            depth -= df[i,:distance]
        else
            println("Unknown input", df[i,:direction])
            break
        end
    end

    hpos, depth
end

function navigate_df2(df)
    
    hpos, depth = 0, 0

    tbl = Tables.rowtable(df) # creates vector of NamedTuple(s)
    for row in Tables.rows(tbl)
        if row.direction == "forward" 
            hpos += row.distance
        elseif row.direction == "reverse"
            hpos -= row.distance
        elseif row.direction == "down"
            depth += row.distance
        elseif row.direction == "up"
            depth -= row.distance
        else
            println("Unknown input", row.direction)
            break
        end
    end

    hpos, depth
end

ho, dp = navigate_df(course_df)
ho, dp = navigate_df2(course_df)

ho * dp # product is result sought.


#= Part 2
--- Part Two ---

Based on your calculations, the planned course doesn't seem to make any sense.
You find the submarine manual and discover that the process is actually
slightly more complicated.

In addition to horizontal position and depth, you'll also need to track a
third value, aim, which also starts at 0. The commands also mean something
entirely different than you first thought:

    down X increases your aim by X units.
    up X decreases your aim by X units.
    forward X does two things:
        It increases your horizontal position by X units.
        It increases your depth by your aim multiplied by X.

Again note that since you're on a submarine, down and up do the opposite of what you might expect: "down" means aiming in the positive direction.

Now, the above example does something different:

    forward 5 adds 5 to your horizontal position, a total of 5. Because your aim is 0, your depth does not change.
    down 5 adds 5 to your aim, resulting in a value of 5.
    forward 8 adds 8 to your horizontal position, a total of 13. Because your aim is 5, your depth increases by 8*5=40.
    up 3 decreases your aim by 3, resulting in a value of 2.
    down 8 adds 8 to your aim, resulting in a value of 10.
    forward 2 adds 2 to your horizontal position, a total of 15. Because your aim is 10, your depth increases by 2*10=20 to a total of 60.

After following these new instructions, you would have a horizontal position of 15
and a depth of 60. (Multiplying these produces 900.)

Using this new interpretation of the commands, calculate the horizontal
position and depth you would have after following the planned course.
What do you get if you multiply your final horizontal position by your final depth?

=#


function navigate_aim_df(df)
    
    hpos, depth, aim = 0, 0, 0

    tbl = Tables.rowtable(df) # creates vector of NamedTuple(s)
    for row in Tables.rows(tbl)
        if row.direction == "forward" 
            hpos += row.distance
            depth += (aim * row.distance)
            # forward X does two things:
            # It increases your horizontal position by X units.
            # It increases your depth by your aim multiplied by X.
        elseif row.direction == "reverse"
            println("Unknown input", row.direction)
            break
            # hpos -= row.distance
        elseif row.direction == "down"
            # down X increases your aim by X units.
            aim += row.distance
        elseif row.direction == "up"
            # up X decreases your aim by X units.
            aim -= row.distance
        else
            println("Unknown input", row.direction)
            break
        end
    end

    hpos, depth, aim
end

ho, dp, am = navigate_aim_df(course_df)
ho * dp # product is result sought.

# ====================
course_df.hmove = [x == "forward" ? true : false for x in course_df.direction]
first(course_df, 5)

# for DataFrame operations, see [Data Wrangling with DataFrames.jl]()
DataFrame(x = [1,2,3], y = 4:6, z = 9)
DataFrame("x" => [1,2], "y" => [3,4])
DataFrame(rand(5, 3), [:x, :y, :z])

