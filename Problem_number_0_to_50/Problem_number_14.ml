(*The following iterative sequence is defined for the set of positive integers:

  n -> n/2 (n is even)
  n -> 3n + 1 (n is odd)

  Using the rule above and starting with 13, we generate the following sequence: 

  13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1

  It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms.
Although it has not been proved yet (Collatz Problem), it is thought that all starting
numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.*)

let collatz n =
  let rec collatz_length n acc =
    if n = 1 then
      acc + 1
    else if n mod 2 = 0 then
      collatz_length (n/2) (acc + 1)
    else 
      collatz_length (3 * n + 1) (acc + 1)
  in 
  collatz_length n 1

let longest_collatz_under n =
  let longest_length = ref 0 in
  let longest_number = ref 0 in
  for i = 1 to n - 1 do
    let length = collatz i in
    if length > !longest_length then begin
      longest_length := length;
      longest_number := i
    end
  done;
  !longest_number

let () =
  let result = longest_collatz_under 1000000 in 
  Printf.printf "The starting number under one million that produces the longest chain is: %d\n" result