(** Parsing of s-expressions. *)

(** The S-expression type *)
type t =
  | Atom of Atom.t
  | Quoted_string of string
  | List of t list
  | Template of Template.t

(** Raises if the argument is not a valid unquoted atom *)
val atom : string -> t

(** Produces [Atom _] if the argument is a valid unquoted atom, otherwise
    produces [Quoted_string _] *)
val atom_or_quoted_string : string -> t

(** Serialize a S-expression *)
val to_string : t -> string

(** Serialize a S-expression using indentation to improve readability *)
val pp : t -> _ Pp.t
