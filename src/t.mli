(** Parsing of s-expressions. *)

(** The S-expression type

    Atoms are used for syntactic elements such as stanza names, field names,
    etc. For data such as library names, dune will accept either an atom or
    a quoted string. A template is simply an atom or quoted string with at
    least one variable.

    Some variables such as [%{deps}] expands to list of values. When expanding
    such variables in a template that is itself inside a list, such as in
    [(run prog %{deps})]:

    - If the template is a quoted string, it will expand to a single element.
      The values will be concatenated and separated by spaces.
    - If the template is an atom, it will expand to multiple elements.

    More precisely, the two following stanzas mean the same thing:

{[
(rule
 (targets x)
 (deps a b)
 (action (run prog %{deps})))

(rule
 (targets x)
 (deps a b)
 (action (run prog a b)))
]}

    and the two following stanzas mean the same thing:

{[
(rule
 (targets x)
 (deps a b)
 (action (run prog --command "plop %{deps}")))

(rule
 (targets x)
 (deps a b)
 (action (run prog --command "plop a b")))
]}

    Lexical conventions are specified in the dune user manual
    at https://dune.readthedocs.io/en/stable/lexical-conventions.html.
*)
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
