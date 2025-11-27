(*If we list all the natural numbers below 10 that are multiples of 3 or 5,
 we get 3, 5, 6 and 9. The sum of these multiples is 23.
 Find the sum of all the multiples of 3 or 5 below 1000*)

let sum_mul_three_five n =
  let rec sum_mul_tree_five_aux i acc =
    if i = n then acc
    else if i mod 3 = 0 then sum_mul_tree_five_aux (i+1) (acc+i)
    else if i mod 5 = 0 then sum_mul_tree_five_aux (i+1) (acc+i)
    else sum_mul_tree_five_aux (i+1) (acc)
  in sum_mul_tree_five_aux 0 0

let () = 
  let result = sum_mul_three_five 1000 in
  Printf.printf "The sum of all the multiples of 3 or 5 below 1000 is: %d\n" result