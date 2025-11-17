(*A palindromic number reads the same both ways. The largest palindrome made from the
product of two 2-digit numbers is 9009 = 91 * 99
Find the largest palindrome made from the product of two 3-digit numbers.*)

let is_palindrome n =
  let s = string_of_int n in
  let len = String.length s in
  let rec check i =
    if i >= len / 2 then true
    else if s.[i] == s.[len - i - 1] then check (i + 1)
    else false
  in
  check 0

let largest_palindrome_product () =
  let rec loop i j max_palindrome =
    if i == 0 then max_palindrome
    else if j == 0 then loop (i - 1) 999 max_palindrome
    else if is_palindrome (i*j) && i*j > max_palindrome then loop i (j-1) (i*j)
    else loop i (j-1) max_palindrome
  in
  loop 999 999 0

let () =
  let result = largest_palindrome_product () in
  Printf.printf "The largest palindrome made from the product of two 3-digit numbers is: %d\n" result  
