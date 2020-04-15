open! StdLabels

type t =
  | Atom of Atom.t
  | Quoted_string of string
  | List of t list
  | Template of Template.t

let atom_or_quoted_string s =
  match Atom.parse s with
  | Some x -> Atom x
  | None -> Quoted_string s

let atom s = Atom (Atom.of_string s)

let rec to_string t =
  match t with
  | Atom a -> Atom.to_string a
  | Quoted_string s -> Escape.quoted s
  | List l ->
    Printf.sprintf "(%s)" (List.map l ~f:to_string |> String.concat ~sep:" ")
  | Template t -> Template.to_string t

let rec pp = function
  | Atom s -> Pp.verbatim (Atom.to_string s)
  | Quoted_string s -> Pp.verbatim (Escape.quoted s)
  | List [] -> Pp.verbatim "()"
  | List l ->
    let open Pp.O in
    Pp.box ~indent:1
      ( Pp.char '('
      ++ Pp.hvbox (Pp.concat_map l ~sep:Pp.space ~f:pp)
      ++ Pp.char ')' )
  | Template t -> Template.pp t
