(*A number is a perfect square, or a square number, if it is the square of a positive integer.
For example, 25 is a square number because 5*5 = 25; it is also an odd square.
The first 5 square numbers are: 1, 4, 9, 16, 25, and the sum of the odd squares is 1 + 9 + 25 = 35.

Among the first 881 thousand square numbers, what is the sum of all the odd squares?*)

let sum_square n =
  let rec sum_square_aux i acc=
    if i = n then i * i + acc
    else if i > n then acc
    else sum_square_aux (i+2) (acc  + i*i)
  in sum_square_aux 1 0

let () = Printf.printf "%s \n" (string_of_int (sum_square 881000))