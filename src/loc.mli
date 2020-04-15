type t =
  { start : Lexing.position
  ; stop : Lexing.position
  }

val in_file : string -> t

val in_dir : string -> t

val none : t

val is_none : t -> bool

val drop_position : t -> t

val of_lexbuf : Lexing.lexbuf -> t

val equal : t -> t -> bool

(** To be used with [__POS__] *)
val of_pos : string * int * int * int -> t

(** Prints [<file>:<line>] *)
val to_file_colon_line : t -> string

(** Prints [File "xxx", line xxx, characters xxx-xxx:] *)
val to_human_readable_location : t -> string

val on_same_line : t -> t -> bool

val span : t -> t -> t
