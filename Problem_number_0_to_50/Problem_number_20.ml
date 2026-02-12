(*n! means n * (n - 1) * ... * 3 * 2 * 1.

For exemple, 10! = 10 * 9 * ... * 3 * 2 * 1 = 3628800,
and the sum of the digits in the nimber 10! is 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Find the sum of the digits in the number 100!.*)

let multiply big n =
  let rec aux digits carry =
    match digits with
    | [] ->
        if carry = 0 then []
        else (carry mod 10) :: aux [] (carry / 10)
    | d :: rest ->
        let prod = d * n + carry in
        (prod mod 10) :: aux rest (prod / 10)
  in
  aux big 0

let factorial n =
  let rec factorial_aux i acc =
    if i > n then acc
    else factorial_aux (i + 1) (multiply acc i)
  in factorial_aux 1 [1]

let sum_digits digits = List.fold_left (+) 0 digits

let () =
  let result = sum_digits (factorial 100) in
  Printf.printf " The sum of the digits in the number 100! is : %d\n" result