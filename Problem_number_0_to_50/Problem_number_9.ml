(*A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
a^2 + b^2 = c^2.
For exemple, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.*)

let pythagorean_triplet n =
  let rec pythagorean_triplet_aux a b c =
    if a + b + c = n && a*a + b*b = c*c then (a, b, c)
    else if c < n then pythagorean_triplet_aux a b (c+1)
    else if b < n then pythagorean_triplet_aux a (b+1) (b+2)
    else if a < n then pythagorean_triplet_aux (a+1) (a+2) (a+3)
    else failwith "No solution"
  in pythagorean_triplet_aux 1 2 3

let () =
  let (a, b, c) = pythagorean_triplet 1000 in
  Printf.printf "Pythagorean triplet (a, b, c) with a + b + c = 1000: (%d, %d, %d)\n" a b c;
  Printf.printf "Product abc = %d\n" (a * b * c)