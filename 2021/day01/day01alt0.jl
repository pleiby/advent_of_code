# source: https://github.com/stevensonmt/advent_of_code/tree/master/2021

function get_input(path)
  Base.readlines(path)
end

function process(input)
  collect(Base.Iterators.map(n -> parse(Int64, n), input))
end 

# this seems a very cumbersome/abstract approach
# and yields a complex data structure (array of views?)
function get_windows(processed, window_size, step)
  ((@view processed[i:i+window_size-1]) for i in 1:step:length(processed) - window_size + step)
end

function incremented(windows)
  collect(Base.Iterators.filter(n -> first(n) < last(n), windows))
end

single_increments = "2021/day01/input.txt" |> 
    get_input |> 
    process |> 
    p -> get_windows(p, 2, 1) |> 
    incremented

trio_increments = "2021/day01/input.txt" |> 
    get_input |> 
    process |> 
    p -> get_windows(p, 4, 1) |> 
    incremented

p1 = length(single_increments)
println("Day01 pt1: $p1")

p2 = length(trio_increments)
println("Day01 pt2: $p2")
