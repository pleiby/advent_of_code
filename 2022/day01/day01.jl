# day01.jl

"""
The number of Calories each Elf is carrying (your puzzle input).

The Elves take turns writing down the number of Calories contained by the various meals, snacks, rations, etc. that they've brought with them, one item per line. Each Elf separates their own inventory from the previous Elf's inventory (if any) by a blank line.

For example, suppose the Elves finish writing their items' Calories and end up with the following list:

1000
2000
3000

4000

5000
6000

7000
8000
9000

10000

This list represents the Calories of the food carried by five Elves:

    The first Elf is carrying food with 1000, 2000, and 3000 Calories, a total of 6000 Calories.
    The second Elf is carrying one food item with 4000 Calories.
    The third Elf is carrying food with 5000 and 6000 Calories, a total of 11000 Calories.
    The fourth Elf is carrying food with 7000, 8000, and 9000 Calories, a total of 24000 Calories.
    The fifth Elf is carrying one food item with 10000 Calories.

In case the Elves get hungry and need extra snacks, they need to know which Elf to ask: they'd like to know how many Calories are being carried by the Elf carrying the most Calories. In the example above, this is 24000 (carried by the fourth Elf).

Find the Elf carrying the most Calories. How many total Calories is that Elf carrying?
"""

input_source_url = "https://adventofcode.com/2022/day/1/input"
input_source_filename = "input.txt"

input_data = readlines("./2022" * "/day01/" * input_source_filename)

function max_calorie_elf(data)
    maxcal = 0
    curr_elf_cal = 0

    for l in data
        if l == ""
            maxcal = max(maxcal, curr_elf_cal)
            curr_elf_cal = 0
        else
            # method is used to convert the String into Integer datatype
            curr_elf_cal += parse(Int64, l)
        end
    end
    max_cal = max(maxcal, curr_elf_cal) # check cal of last elf

end

max_calorie_elf(input_data)
## 74711

function count_elf_calories(data)
    elves = Int64[]

    curr_elf_cal = 0

    for l in data
        if l == "" # blank between lines for each elf
            push!(elves, curr_elf_cal)
            curr_elf_cal = 0
        else
            # method is used to convert the String into Integer datatype
            curr_elf_cal += parse(Int64, l)
        end
    end
    push!(elves, curr_elf_cal)

    return (elves) # array of elf calories
end

elf_calories = count_elf_calories(input_data)

print(first(sort(elf_calories, rev=true), 3))



using Pipe
@pipe input_data |>
      count_elf_calories |>
      sort(_, rev=true) |>
      first(_, 3) |>
      sum

