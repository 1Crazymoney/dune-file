type t = A of string [@@unboxed]

let equal (A a) (A b) = String.equal a b

let is_valid =
  let rec loop s i len =
    i = len
    ||
    match String.unsafe_get s i with
    | '%' -> after_percent s (i + 1) len
    | '"'
    | '('
    | ')'
    | ';'
    | '\000' .. '\032'
    | '\127' .. '\255' ->
      false
    | _ -> loop s (i + 1) len
  and after_percent s i len =
    i = len
    ||
    match String.unsafe_get s i with
    | '%' -> after_percent s (i + 1) len
    | '"'
    | '('
    | ')'
    | ';'
    | '\000' .. '\032'
    | '\127' .. '\255'
    | '{' ->
      false
    | _ -> loop s (i + 1) len
  in
  fun s ->
    let len = String.length s in
    len > 0 && loop s 0 len

let parse s =
  if is_valid s then
    Some (A s)
  else
    None

let of_string s =
  match parse s with
  | Some x -> x
  | None -> invalid_arg "Atom.of_string"

let to_string (A s) = s

let of_int i = of_string (string_of_int i)

let of_float x = of_string (string_of_float x)

let of_bool x = of_string (string_of_bool x)
