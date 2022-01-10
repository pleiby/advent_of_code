#= 
--- Day 4: Giant Squid ---

You're already almost 1.5km (almost a mile) below the surface of the ocean, 
already so deep that you can't see any sunlight. What you can see, however, 
is a giant squid that has attached itself to the outside of your submarine.

Maybe it wants to play bingo?

Bingo is played on a set of boards each consisting of a 5x5 grid of numbers. 
Numbers are chosen at random, and the chosen number is marked on all boards 
on which it appears. (Numbers may not appear on all boards.) If all numbers 
in any row or any column of a board are marked, that board wins. 
(Diagonals don't count.)

The submarine has a bingo subsystem to help passengers (currently, you and 
the giant squid) pass the time. It automatically generates a random order 
in which to draw numbers and a random set of boards (your puzzle input). 
For example:

7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7

After the first five numbers are drawn (7, 4, 9, 5, and 11), there are no winners, but the boards are marked as follows (shown here adjacent to each other to save space):

22 13 17 11  0         3 15  0  2 22        14 21 17 24  4
 8  2 23  4 24         9 18 13 17  5        10 16 15  9 19
21  9 14 16  7        19  8  7 25 23        18  8 23 26 20
 6 10  3 18  5        20 11 10 24  4        22 11 13  6  5
 1 12 20 15 19        14 21 16 12  6         2  0 12  3  7

After the next six numbers are drawn (17, 23, 2, 0, 14, and 21), there are still no winners:

22 13 17 11  0         3 15  0  2 22        14 21 17 24  4
 8  2 23  4 24         9 18 13 17  5        10 16 15  9 19
21  9 14 16  7        19  8  7 25 23        18  8 23 26 20
 6 10  3 18  5        20 11 10 24  4        22 11 13  6  5
 1 12 20 15 19        14 21 16 12  6         2  0 12  3  7

Finally, 24 is drawn:

22 13 17 11  0         3 15  0  2 22        14 21 17 24  4
 8  2 23  4 24         9 18 13 17  5        10 16 15  9 19
21  9 14 16  7        19  8  7 25 23        18  8 23 26 20
 6 10  3 18  5        20 11 10 24  4        22 11 13  6  5
 1 12 20 15 19        14 21 16 12  6         2  0 12  3  7

At this point, the third board wins because it has at least one complete row 
or column of marked numbers (in this case, the entire top row is marked:
 14 21 17 24 4).

The score of the winning board can now be calculated. 
Start by finding the sum of all unmarked numbers on that board; 
 in this case, the sum is 188. 
Then, multiply that sum by the number that was just called when the board won, 
 24, to get the final score, 188 * 24 = 4512.

To guarantee victory against the giant squid, 
figure out which board will win first. 
What will your final score be if you choose that board?
=#

using DataFrames
using CSV

# Strategy for Part 1, checking bingo boards
#  iterate over input list of drawn_numbers (until one board wins - assume no ties)
#    iterate over all boards (to update and check for win)
#      iterate over all board elements (rows and columns) (to look for matches)
#        replace board numbers that match drawn_number with 0
#      iterate over all rows and columns (to check each board for win)
#        declare win if row sum or column sum = 0
#        return winning board number and last drawn_number
#  Score winning board (if one found)
#    sum all non-called elements (non-called, since called are zero)

lines = readlines("./2021/day04/test.txt")
test_drawn_numbers = split(lines[1], ",")
parse1Int(x) = parse(Int64, x)
test_drawn_numbers = map(parse1Int, test_drawn_numbers)

k = 1

for _ in 1:5
    board[k, parse.(Int, split(lines[3]) )

XXX

["23" "15"] |> parse1Int
# result for Part 1:
println("Part 1: ", 0) # product is Part 1 result sought.
## Part 1: 0 # Checked, correct

test_drawn_numbers = [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]

test_boards = [
22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
]

#### Part 2
#=
--- Part Two ---

=#

println("Part 2: ", O2_generator * CO2_scrubber) # product is Part 2 result sought.
## Part 2: 0 # Checked, correct
