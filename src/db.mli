
type filename = string

module RO: sig

  type t

  (** [open_existing fn] open in read-only mode the persistent
      hashtbl whose data are stored in file [fn] and whose
      index hashtbl is stored in [fn ^ ".idx"]. *)
  val open_existing: filename -> t

  (** [close db] close the previously opened [db]. *)
  val close: t -> unit

  (** [mem db k] check if [k] is bound in [db]. *)
  val mem: t -> string -> bool

  (** [find db k] get the current binding of [k] in [db]
      or raise [Not_found]. *)
  val find: t -> string -> string

  (** [iter f db] apply [f] to all key-value pairs in [db].
      Cf. Hashtbl.iter for details. *)
  val iter: (string -> string -> unit) -> t -> unit

  (** [fold f db init] fold [f] over all key-value pairs in [db].
      Cf. Hashtbl.fold for details. *)
  val fold: (string -> string -> 'a -> 'a) -> t -> 'a -> 'a

end

module ROZ: sig

  type t

  (** [open_existing fn] open in read-only mode the persistent
      hashtbl whose data are stored compressed in file [fn] and whose
      index hashtbl is stored in [fn ^ ".idx"]. *)
  val open_existing: filename -> t

  (** [close db] close the previously opened [db]. *)
  val close: t -> unit

  (** [mem db k] check if [k] is bound in [db]. *)
  val mem: t -> string -> bool

  (** [find db k] get and uncompress the current binding of [k] in [db]
      or raise [Not_found]. *)
  val find: t -> string -> string

  (** [iter f db] apply [f] to all key-value pairs in [db].
      Values are uncompressed on the fly.
      Cf. Hashtbl.iter for details. *)
  val iter: (string -> string -> unit) -> t -> unit

  (** [fold f db init] fold [f] over all key-value pairs in [db].
      Values are uncompressed on the fly.
      Cf. Hashtbl.fold for details. *)
  val fold: (string -> string -> 'a -> 'a) -> t -> 'a -> 'a

end

(*

module RW: sig

  type t

  val create fn =

  val open_existing fn =

  val close db =

  val sync db =

  val destroy db =

  val mem db k =

  val add db k str =

  val replace db k str =

  val remove db k =

  val find db k =

  val iter f db =

  val fold f db init =

end

module RWZ: sig

  type t

  val create fn =

  val open_existing fn =

  val close db =

  val sync db =

  val destroy db =

  val mem db k =

  val add db k str =

  val replace db k str =

  val remove db k =

  val find db k =

  val iter f db =

  val fold f db init =

end

*)
