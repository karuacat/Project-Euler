(* The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143*)

let is_prime_number n =
  let rec is_prime_number_aux i =
    if i * i > n then true
    else if n mod i = 0 then false
    else is_prime_number_aux (i+1)
  in is_prime_number_aux 2

let largest_prime_factor n =
  let rec largest_prime_factor_aux i current_largest =
    if i * i > n then
      if n > current_largest && is_prime_number n then n
      else current_largest
    else if n mod i = 0 && is_prime_number i then
      largest_prime_factor_aux (i+1) i
    else largest_prime_factor_aux (i+1) current_largest
  in largest_prime_factor_aux 2 0

let() =
  let result = largest_prime_factor 600851475143 in
  Printf.printf "The largest prime factor of 600851475143 is: %d\n" result