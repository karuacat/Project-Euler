(*The sum of the squares of the first ten natural numbers is,
1^2 + 2^2 + ... + 10^2 = 385.
The square of the sum of the first ten natural numbers is,
(1+2+...+10)^2 = 55^2 = 3025.
Hence the difference between the sum of the squares of the first ten natural numbers and
the square of the sum is 3025-385 = 2640.
Find the difference between the sum of the squares of the first one hundred natural
numbers and the square of the sum. *)

let sum_square_difference n =
  let rec sum_square_difference_aux i sum_square sum =
    if i > n then sum * sum - sum_square
    else sum_square_difference_aux (i+1) (sum_square + i * i) (sum + i)
  in sum_square_difference_aux 1 0 0

let () =
  let result = sum_square_difference 100 in
  Printf.printf "The difference between the sum of the squares and the square of the sum of the first 100 natural numbers is: %d\n" result