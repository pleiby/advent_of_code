#=
--- Day 3: Binary Diagnostic ---

The submarine has been making some odd creaking noises, so you ask
it to produce a diagnostic report just in case.

The diagnostic report (your puzzle input) consists of a list of binary
numbers which, when decoded properly, can tell you many useful things
about the conditions of the submarine. The first parameter to check is
the power consumption.

You need to use the binary numbers in the diagnostic report to generate
two new binary numbers (called the gamma rate and the epsilon rate).
The power consumption can then be found by multiplying the gamma rate
by the epsilon rate.

Each bit in the gamma rate can be determined by finding the most common
bit in the corresponding position of all numbers in the diagnostic report.
For example, given the following diagnostic report:

00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010

Considering only the first bit of each number, there are five 0 bits
and seven 1 bits. Since the most common bit is 1, the first bit of the
gamma rate is 1.

The most common second bit of the numbers in the diagnostic report is 0,
so the second bit of the gamma rate is 0.

The most common value of the third, fourth, and fifth bits are 1, 1, and 0,
respectively, and so the final three bits of the gamma rate are 110.

So, the gamma rate is the binary number 10110, or 22 in decimal.

The epsilon rate is calculated in a similar way; rather than use the most
common bit, the least common bit from each position is used. So, the
epsilon rate is 01001, or 9 in decimal. Multiplying the gamma rate (22)
by the epsilon rate (9) produces the power consumption, 198.

Use the binary numbers in your diagnostic report to calculate the gamma rate
and epsilon rate, then multiply them together.
What is the power consumption of the submarine?
(Be sure to represent your answer in decimal, not binary.)

Notes:
- gamma rate: Each bit in the (integral) gamma rate can be determined by finding the most common
bit in the corresponding position of all numbers in the diagnostic report.

- epsilon rate is least common bit, hence complement of unsigned binary representation of gamma rate

- result to be reported is gamma * epsilon

Q: no clear guidance if a tie in bit frequency. 
=#

using DataFrames
using CSV

test_input = [
    "00100"
    "11110"
    "10110"
    "10111"
    "10101"
    "01111"
    "00111"
    "11100"
    "10000"
    "11001"
    "00010"
    "01010"
]

(test_input[1][1])


"""
    function count_ones(input_string_vector)

Scan input strings and count total number of '1's in each character position
"""
function count_ones(input_string_vector)
    nbits = length(input_string_vector[1]) # determine anticipated length of strings
    counts = zeros(nbits)

    for s in input_string_vector
        for b in 1:nbits
            if s[b] == '1'
                counts[b] += 1
            end # assume else s[b] == '0'
        end
    end
    return(counts)
end

"""
    function count_ones_in_bit_pos(input_string_vector, b)
        
Scan input strings and count total number of '1's in character/bit position b
"""
function count_ones_in_bit_pos(input_string_vector, b)
    nbits = length(input_string_vector[1]) # determine anticipated length of strings
    count = 0
    
    if 1 <= b <= nbits   
        for s in input_string_vector
            if s[b] == '1'
                count += 1
            end # assume else s[b] == '0'
        end
    end
    return(count)
end

# count the frequency of ones at each position in string
# determine fraction of '1's
countfracs = count_ones(test_input) ./ length(test_input)

function gammaepsilon_by_countfracs(countfracs)
    gam = 0
    eps = 0

    gamma_string = ""
    epsilon_string = ""

    nbits = length(countfracs)
    pwroftwo = 1
    
    for b in nbits:-1:1
        if countfracs[b] >= 0.5 # more than half were '1's, so count this bit value for gamma
            gam += pwroftwo
        else # otherwise '0' is more common, so count this bit value for epsilon
            eps += pwroftwo
        end
        pwroftwo *= 2 # next power of 2
    end
    print(gamma_string, epsilon_string)

    return(gam, eps)
end

gamma, epsilon = gammaepsilon_by_countfracs(countfracs)

gamma, epsilon

gamma * epsilon

# Now apply these steps to the input data 

# read space-delimited data into a DataFrame (know column is to be text)
data_input = CSV.read("2021/day03/input.txt",
                        DataFrame,
                        header = false,
                        delim = ' ',
                        types = String)

# Note this example of more general specification of column types for `CSV.read`:
#   types = Array{DataType,1}([String, Int, String, Float64])
#   CSV.read(IOBuffer(data), DataFrame; types=types)

data_input = data_input[!,1] # since read to DataFrame, take first (only) column

# count the frequency of ones at each position in string
# determine fraction of '1's
countfracs = count_ones(data_input) ./ length(data_input)

gamma, epsilon = gammaepsilon_by_countfracs(countfracs)

gamma, epsilon

# result for Part 1:
println("Part 1: ", gamma * epsilon) # product is Part 1 result sought.
## Part 1: 2583164

#### Part 2
#=
--- Part Two ---

Next, you should verify the life support rating, which can be determined
 by multiplying the oxygen generator rating by the CO2 scrubber rating.

Both the oxygen generator rating and the CO2 scrubber rating are values
that can be found in your diagnostic report - finding them is the tricky part.
Both values are located using a similar process that involves filtering
out values until only one remains. Before searching for either rating value,
start with the full list of binary numbers from your diagnostic report
and consider just the first bit of those numbers. Then:

    Keep only numbers selected by the bit criteria for the type of rating
    value for which you are searching.
    Discard numbers which do not match the bit criteria.
    If you only have one number left, stop; this is the rating value for which you are searching.
    Otherwise, repeat the process, considering the next bit to the right.

The bit criteria depends on which type of rating value you want to find:

    To find oxygen generator rating,
      determine the most common value (0 or 1) in the current bit position,
      and keep only numbers with that bit in that position.
      If 0 and 1 are equally common, keep values with a 1 in the position being considered.
    To find CO2 scrubber rating,
      determine the least common value (0 or 1) in the current bit position,
      and keep only numbers with that bit in that position.
      If 0 and 1 are equally common, keep values with a 0 in the position being considered.

For example, to determine the oxygen generator rating value using the same example diagnostic report from above:

    Start with all 12 numbers and consider only the first bit of each number. There are more 1 bits (7) than 0 bits (5), so keep only the 7 numbers with a 1 in the first position: 11110, 10110, 10111, 10101, 11100, 10000, and 11001.
    Then, consider the second bit of the 7 remaining numbers: there are more 0 bits (4) than 1 bits (3), so keep only the 4 numbers with a 0 in the second position: 10110, 10111, 10101, and 10000.
    In the third position, three of the four numbers have a 1, so keep those three: 10110, 10111, and 10101.
    In the fourth position, two of the three numbers have a 1, so keep those two: 10110 and 10111.
    In the fifth position, there are an equal number of 0 bits and 1 bits (one each). So, to find the oxygen generator rating, keep the number with a 1 in that position: 10111.
    As there is only one number left, stop; the oxygen generator rating is 10111, or 23 in decimal.

Then, to determine the CO2 scrubber rating value from the same example above:

    Start again with all 12 numbers and consider only the first bit of each number.
    There are fewer 0 bits (5) than 1 bits (7), so keep only the 5 numbers with a 0 in the first position: 00100, 01111, 00111, 00010, and 01010.
    Then, consider the second bit of the 5 remaining numbers: there are fewer 1 bits (2) than 0 bits (3), so keep only the 2 numbers with a 1 in the second position: 01111 and 01010.
    In the third position, there are an equal number of 0 bits and 1 bits (one each). So, to find the CO2 scrubber rating, keep the number with a 0 in that position: 01010.
    As there is only one number left, stop; the CO2 scrubber rating is 01010, or 10 in decimal.

Finally, to find the life support rating, multiply the oxygen generator rating (23)
by the CO2 scrubber rating (10) to get 230.

Use the binary numbers in your diagnostic report to calculate the oxygen generator rating and CO2 scrubber rating, then multiply them together. What is the life support rating of the submarine? (Be sure to represent your answer in decimal, not binary.)
=#

count_ones_in_bit_pos(test_input, 5)

# Keep only numbers selected by the `bit_criteria`` for the type of rating
#     value for which you are searching.
#     Discard numbers which do not match the bit criteria.
#     If you only have one number left, stop; this is the rating value for which you are searching.
#     Otherwise, repeat the process, considering the next bit to the right.
#     Note: no guarantee this will stop with only one number before bits are exhausted.
# 

function bit_criteria(rating, filtered_input, b)
    n_ones = count_ones_in_bit_pos(filtered_input, b)
    n_zeros = (length(filtered_input) - n_ones) # strict assumption that input is only 1s and 0s

    if (rating == "O2_generator")
        # for rating == O2_generator,
        #  determine the _most_ common value (0 or 1) in the current bit position,
        #  and keep only numbers with that most common bit in that position.
        #  If 0 and 1 are equally common, keep values with a 1 in the position being considered.
        if (n_ones >= n_zeros)
            filtered_input = filter(x -> x[b] == '1', filtered_input) # keep ones
        else
            filtered_input = filter(x -> x[b] == '0', filtered_input)
        end
    elseif (rating == "CO2_scrubber")
        # for rating == CO2_scrubber rating, 
        #  determine the _least_ common value (0 or 1) in the current bit position,
        #  and keep only numbers with that bit in that position.
        #  If 0 and 1 are equally common, keep values with a 0 in the position being considered.
        if (n_ones >= n_zeros)
            filtered_input = filter(x -> x[b] == '0', filtered_input) # keep zeros
        else
            filtered_input = filter(x -> x[b] == '1', filtered_input)
        end

    end

    filtered_input
end

function zero_one_string_binary_value(zero_one_string)
    nbits = length(zero_one_string)
    pwroftwo = 1
    bvalue = 0

    for b in nbits:-1:1
        if zero_one_string[b] == '1'
            bvalue += pwroftwo
        else # otherwise '0' is more common, so count this bit value for epsilon
            # no value
        end
        pwroftwo *= 2 # next power of 2
    end

    return bvalue
end

filtered_input = test_input
nbits = length(filtered_input[1]) # how long is each bit string

for b in 1:nbits
    global filtered_input = bit_criteria("O2_generator", filtered_input, b)
    if length(filtered_input) == 1
        break
    end
end

filtered_input

O2_generator = zero_one_string_binary_value(filtered_input[1])

filtered_input = test_input
for b in 1:nbits
    global filtered_input = bit_criteria("CO2_scrubber", filtered_input, b)
    if length(filtered_input) == 1
        break
    end
end

filtered_input
filtered_input[1]

CO2_scrubber = zero_one_string_binary_value(filtered_input[1])

# Now apply these Part 2 steps to the input data

filtered_input = data_input
nbits = length(filtered_input[1]) # how long is each bit string

for b in 1:nbits
    global filtered_input = bit_criteria("O2_generator", filtered_input, b)
    if length(filtered_input) == 1
        break
    end
end

filtered_input

O2_generator = zero_one_string_binary_value(filtered_input[1])

filtered_input = data_input
for b in 1:nbits
    global filtered_input = bit_criteria("CO2_scrubber", filtered_input, b)
    if length(filtered_input) == 1
        break
    end
end

filtered_input
filtered_input[1]

CO2_scrubber = zero_one_string_binary_value(filtered_input[1])

println("Part 2: ", O2_generator * CO2_scrubber) # product is Part 2 result sought.
## Part 2: 2784375 # Checked, correct

# ====================
# Misc experiments
# Misc Experiments Asides, Other approaches in Julia:
println("Misc Experiments")

# filter(row -> row.x > 1, test_input)
# filter(x -> x[5] == '1', test_input)


# char to int and back
# Char.(test_input) # does not work
Char(120) # = 'x'
Int('x') # = 120

# Also could use `reinterpret``:

a = ['A'  'T'  'C']

b = reinterpret(Int32, a)
a[1]
b[1] # a little tricky because the characters are Unicode