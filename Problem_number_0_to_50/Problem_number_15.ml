(*Starting in the top left corner of a 2*2 grid, and only being able to move to the right
and down, there are exactly 6 routes to the bottom right corner.
How many such routes are there through a 20*20grid?*)

let binomial n k =
  let k = min k (n - k) in
  let result = ref 1 in
  for i = 1 to k do
    result := !result * (n - k + i) / i
  done;
  !result
  
let () = 
  let result = binomial 40 20 in
  Printf.printf "Number of routes through a 20x20 grid: %d\n" result