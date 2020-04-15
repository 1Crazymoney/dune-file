type t =
  { start : Lexing.position
  ; stop : Lexing.position
  }

let none_pos p : Lexing.position =
  { pos_fname = p; pos_lnum = 1; pos_cnum = 0; pos_bol = 0 }

let none =
  let pos = none_pos "<none>" in
  { start = pos; stop = pos }

let in_file p =
  let pos = none_pos p in
  { start = pos; stop = pos }

let in_dir = in_file

let drop_position (t : t) =
  let pos = none_pos t.start.pos_fname in
  { start = pos; stop = pos }

let of_lexbuf lexbuf : t =
  { start = Lexing.lexeme_start_p lexbuf; stop = Lexing.lexeme_end_p lexbuf }

let equal_position
    { Lexing.pos_fname = f_a; pos_lnum = l_a; pos_bol = b_a; pos_cnum = c_a }
    { Lexing.pos_fname = f_b; pos_lnum = l_b; pos_bol = b_b; pos_cnum = c_b } =
  f_a = f_b && l_a = l_b && b_a = b_b && c_a = c_b

let equal { start = start_a; stop = stop_a } { start = start_b; stop = stop_b }
    =
  equal_position start_a start_b && equal_position stop_a stop_b

let of_pos (fname, lnum, cnum, enum) =
  let pos : Lexing.position =
    { pos_fname = fname; pos_lnum = lnum; pos_cnum = cnum; pos_bol = 0 }
  in
  { start = pos; stop = { pos with pos_cnum = enum } }

let is_none = equal none

let to_file_colon_line t =
  Printf.sprintf "%s:%d" t.start.pos_fname t.start.pos_lnum

let to_human_readable_location { start; stop } =
  let start_c = start.pos_cnum - start.pos_bol in
  let stop_c = stop.pos_cnum - start.pos_bol in
  Printf.sprintf "File \"%s\", line %d, characters %d-%d:" start.pos_fname
    start.pos_lnum start_c stop_c

let on_same_line loc1 loc2 =
  let start1 = loc1.start in
  let start2 = loc2.start in
  let same_file = String.equal start1.pos_fname start2.pos_fname in
  let same_line = Int.equal start1.pos_lnum start2.pos_lnum in
  same_file && same_line

let span begin_ end_ = { begin_ with stop = end_.stop }
