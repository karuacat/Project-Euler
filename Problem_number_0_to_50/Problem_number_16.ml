(*2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
What is the sum of the digits of the number 2^1000 ?*)

let multiply digits n =
  let rec multiply_aux d carry acc =
    match d with
    | [] -> if carry = 0 then acc
            else multiply_aux [] (carry / 10) ((carry mod 10) :: acc)
    | x :: xs ->
      let prod = x * n + carry in
      multiply_aux xs (prod / 10) ((prod mod 10) :: acc)
    in List.rev (multiply_aux digits 0 [])

let power n =
  let rec power_aux i acc =
    if i = 0 then acc
    else power_aux (i - 1) (multiply acc 2)
  in power_aux n [1]

let sum_of_digits digits =
  List.fold_left (+) 0 digits

let () =
  let digits = power 1000 in
  let result = sum_of_digits digits in
  Printf.printf "The sum of the digits of the number 2^1000 is : %d.\n" result