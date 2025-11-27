(*The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17
Find the sum of all the primes below two million.*)

let sum_primes n =
  if n < 2 then 0 else
  let sum = ref 2 in
  let size = (n - 1) / 2 in
  let is_prime = Array.make (size + 1) true in
  let sqrt_n = int_of_float (sqrt (float_of_int n)) in
  let sqrt_index = (sqrt_n - 3) / 2 in
  for i = 0 to sqrt_index do
    if is_prime.(i) then
      let p = 2 * i + 3 in
      let start = (p * p - 3) / 2 in
      for j = start to size do
        if (2 * j + 3) mod p = 0 then is_prime.(j) <- false
      done
  done;
  for i = 0 to size do
    if is_prime.(i) then sum := !sum + (2 * i + 3)
  done;
  !sum

let () =
  let result = sum_primes 2000000 in
  Printf.printf "The sum of all the primes below two million is : %d\n" result