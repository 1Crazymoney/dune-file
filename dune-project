(lang dune 2.0)
(name dune-file)

(license MIT)
(maintainers "Jeremie Dimino <jeremie@dimino.org>")
(authors
  "Jane Street Group, LLC <opensource@janestreet.com>"
  "Jeremie Dimino <jeremie@dimino.org>")
(source (github diml/dune-file))
(documentation "https://diml.github.io/dune-file/")

(generate_opam_files true)

(package
 (name dune-file)
 (depends
   (ocaml (>= 4.08.0))
   (ppx_expect :with-test))
 (synopsis "Toolbox for reading and editing dune files")
 (description "
Provides reading and edition facilities for dune files.
"))
