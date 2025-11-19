(*2520 is the smallest number that can be divided by each of the numbers from 1 to 10
without any remainder.
What is the smallest positive number that is evenly divisible by all the numbers from 1
to 20*)

let is_divible n i =
  n mod i = 0

let smallest_multiple k =
  let rec smallest_multiple_aux n i = 
    if is_divible n i then
      if i = k then n
      else smallest_multiple_aux n (i+1)
    else smallest_multiple_aux (n+1) 1
  in smallest_multiple_aux k 1

let () = 
  let result = smallest_multiple 20 in
  Printf.printf "The smallest positive number that is evenly divisible by all the numbers from 1 to 20 is: %d\n" result