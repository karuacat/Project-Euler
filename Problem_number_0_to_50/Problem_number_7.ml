(*By listing the first six prime numbers : 2, 3, 5, 7, 11, abd 13, we can see that the 6th prime
is 13.
What is the 100001st prime number ?*)

let is_prime_number n =
  let rec is_prime_number_aux i =
    if i * i > n then true
    else if n mod i = 0 then false
    else is_prime_number_aux (i+1)
  in is_prime_number_aux 2

let nth_prime_number n =
  let rec nth_prime_number_aux i acc =
    if is_prime_number i then
      if acc + 1 = n then i
      else nth_prime_number_aux (i + 1) (acc + 1)
    else nth_prime_number_aux (i+1) acc
  in nth_prime_number_aux 2 0

let () =
  let result = nth_prime_number 10001 in
  Printf.printf "The 10001st prime number is: %d\n" result